From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 26 Jul 2013 14:49:22 +0100
Subject: [PATCH] ARM: socfpga: dts: Add support for SD/MMC
In-Reply-To: <1374789881-20611-1-git-send-email-dinguyen@altera.com>
References: <1374789881-20611-1-git-send-email-dinguyen@altera.com>
Message-ID: <1374846562.3213.56.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ding,

Excuse me if the questions below were already asked and feel free to
point me at the appropriate mail archive...

On Thu, 2013-07-25 at 23:04 +0100, dinguyen at altera.com wrote:
> Add bindings for SD/MMC for SOCFPGA.
> Add "syscon" to the "altr,sys-mgr" binding.

Are those two related? As in: what does the "syscon" bit have to do with
"Add(ing) support for SD/MMC"? Should those two be separated?

> +* altr,dw-mshc-ciu-div: Specifies the divider value for the card interface
> +  unit (ciu) clock. The value should be (n-1). For Altera's SOCFPGA, the divider
> +  value is fixed at 3, which means parent_clock/4.

In what circumstances would this be different than 3? Is the interface
in question member of the "hard part" of the SOFPGA, or is it supposed
to be synthesized in the FPGA? 

> +* altr,dw-mshc-sdr-timing: Specifies the value of CIU clock phase shift value
> +  in transmit mode and CIU clock phase shift value in receive mode for single
> +  data rate mode operation. Refer to notes below for the order of the cells and the
> +  valid values.
> +
> +  Notes for the sdr-timing values:
> +
> +    The order of the cells should be
> +      - First Cell: CIU clock phase shift value for RX mode, smplsel bits in
> +	the system manager SDMMC control group.
> +      - Second Cell: CIU clock phase shift value for TX mode, drvsel bits in
> +	the system manager SDMMC control group.
> +
> +    Valid values for SDR CIU clock timing for SOCFPGA:
> +      - valid value for tx phase shift and rx phase shift is 0 to 7.

How does one pick those value? Do they depend on the board design? The
FPGA synthesis options?

I am not trying to be picky, just trying to establish if those value are
"hardware" enough to be present in the tree at all...

I've also noticed that Exynos defines almost identical bindings:

> samsung,dw-mshc-ciu-div
> samsung,dw-mshc-sdr-timing
> samsung,dw-mshc-ddr-timing

Aren't you both using the same "Synopsis Designware Mobile Storage Host
Controller" by any chance? Are you sharing a driver? And if not,
why? ;-) If the timings really must be parametrised, would it be
possible to come up with a common set of "synopsis" properties, instead
of "samsung" and "altr" ones? 

Thanks for your time!

Pawel
