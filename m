From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 14 Sep 2012 10:18:02 +0100
Subject: [PATCH 09/19] ARM: ux500: Enable SSP (SPI) for HREF when booting
 Device Tree
In-Reply-To: <CACRpkdaC_enpxUFNM_wteAQWKER_naUNUH-s1pJtiGzVFSV+og@mail.gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdaC_enpxUFNM_wteAQWKER_naUNUH-s1pJtiGzVFSV+og@mail.gmail.com>
Message-ID: <20120914091800.GJ3374@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 04:11:10AM -0700, Linus Walleij wrote:
> On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Here we add a new SSP node to the HREF's Device Tree file which
> > activates the generic one found in the .dtsi file. This will
> > allow probing of the SSP driver when Device Tree is enabled.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> We have to look closer at this.
> 
> There are merged PL022 DT bindings (by Roland Stigge)
> nowadays, see commit 6d3952a7dfa80919842bbe01ac7f693d40a1eb84
> in linux-next:
> 
>  Optional properties:
> +- num-cs : total number of chipselects
>  - cs-gpios : should specify GPIOs used for chipselects.
>    The gpios will be referred to as reg = <index> in the SPI child nodes.
>    If unspecified, a single SPI device without a chip select can be used.
> 
> +SPI slave nodes must be children of the SPI master node and can
> +contain the following properties.
> +
> +- pl022,interface : interface type:
> +       0: SPI
> +       1: Texas Instruments Synchronous Serial Frame Format
> +       2: Microwire (Half Duplex)
> +- pl022,com-mode : polling, interrupt or dma
> +- pl022,rx-level-trig : Rx FIFO watermark level
> +- pl022,tx-level-trig : Tx FIFO watermark level
> +- pl022,ctrl-len : Microwire interface: Control length
> +- pl022,wait-state : Microwire interface: Wait state
> +- pl022,duplex : Microwire interface: Full/Half duplex
> 
> Currently this is defined as auxdata in board-mop500.c
> but notanly cs-gpios (num chipselects) should come from
> device tree instead.
> 
> It appears Roland has written his bindings such that DT
> data augments platform data (yes, I am also getting crazy
> about this prioritization, mea culpa for ACKing this without
> proper discussion) so it appears that you could actually
> use AUXDATA and some stuff in the DT at the same
> time.
> 
> Or you could keep it like this and only have AUXDATA
> as it stands, I just want a discussion about what is the right
> thing to do before we commit to anything.

Sounds fine.

I'll pull this for now.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
