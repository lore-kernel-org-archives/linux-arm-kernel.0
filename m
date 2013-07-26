From: dinguyen@altera.com (Dinh Nguyen)
Date: Fri, 26 Jul 2013 09:49:45 -0500
Subject: [PATCH] ARM: socfpga: dts: Add support for SD/MMC
In-Reply-To: <1374846562.3213.56.camel@hornet>
References: <1374789881-20611-1-git-send-email-dinguyen@altera.com>
 <1374846562.3213.56.camel@hornet>
Message-ID: <1374850185.20685.12.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

On Fri, 2013-07-26 at 14:49 +0100, Pawel Moll wrote:
> Hello Ding,

Dinh please...
> 
> Excuse me if the questions below were already asked and feel free to
> point me at the appropriate mail archive...
> 
> On Thu, 2013-07-25 at 23:04 +0100, dinguyen at altera.com wrote:
> > Add bindings for SD/MMC for SOCFPGA.
> > Add "syscon" to the "altr,sys-mgr" binding.
> 
> Are those two related? As in: what does the "syscon" bit have to do with
> "Add(ing) support for SD/MMC"? Should those two be separated?

You can reference these 2 threads:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/168470.html
https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-June/035227.html

I hope that you will address your question for syscon.

> 
> > +* altr,dw-mshc-ciu-div: Specifies the divider value for the card interface
> > +  unit (ciu) clock. The value should be (n-1). For Altera's SOCFPGA, the divider
> > +  value is fixed at 3, which means parent_clock/4.
> 
> In what circumstances would this be different than 3? Is the interface
> in question member of the "hard part" of the SOFPGA, or is it supposed
> to be synthesized in the FPGA? 
> 
> > +* altr,dw-mshc-sdr-timing: Specifies the value of CIU clock phase shift value
> > +  in transmit mode and CIU clock phase shift value in receive mode for single
> > +  data rate mode operation. Refer to notes below for the order of the cells and the
> > +  valid values.
> > +
> > +  Notes for the sdr-timing values:
> > +
> > +    The order of the cells should be
> > +      - First Cell: CIU clock phase shift value for RX mode, smplsel bits in
> > +	the system manager SDMMC control group.
> > +      - Second Cell: CIU clock phase shift value for TX mode, drvsel bits in
> > +	the system manager SDMMC control group.
> > +
> > +    Valid values for SDR CIU clock timing for SOCFPGA:
> > +      - valid value for tx phase shift and rx phase shift is 0 to 7.
> 
> How does one pick those value? Do they depend on the board design? The
> FPGA synthesis options?

The sd/mmc is not in the FPGA at all, it is a hardened IP. The values
are implementation specific on how the IP is put down.

> 
> I am not trying to be picky, just trying to establish if those value are
> "hardware" enough to be present in the tree at all...

It is very much tied to the hardware.
> 
> I've also noticed that Exynos defines almost identical bindings:
> 
> > samsung,dw-mshc-ciu-div
> > samsung,dw-mshc-sdr-timing
> > samsung,dw-mshc-ddr-timing

Yes, I agree.
> 
> Aren't you both using the same "Synopsis Designware Mobile Storage Host
> Controller" by any chance? Are you sharing a driver? And if not,
> why? ;-) If the timings really must be parametrised, would it be
> possible to come up with a common set of "synopsis" properties, instead
> of "samsung" and "altr" ones? 

We are using the same driver. This is just a platform specifc entries
for how the IP can be implemented. I also agree that we can come up with
a shared set of properties for these.

But since the platform-driver part has already been picked into the
master tree, can I work on a common set after this patch? That way it
enables SD/MMC to work on SocFPGA for the time being.

Thanks alot for the review.

Dinh
> 
> Thanks for your time!
> 
> Pawel
> 
> 
> 
