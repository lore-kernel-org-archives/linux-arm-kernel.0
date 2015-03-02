From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Mon, 2 Mar 2015 09:59:26 +0000
Subject: [PATCH] ARM: dts: at919260/at91sam9g20: fix SRAM device tree node
In-Reply-To: <20150302095359.GJ4094@piout.net>
References: <1425276209-4899-1-git-send-email-wenyou.yang@atmel.com>
 <20150302095359.GJ4094@piout.net>
Message-ID: <B256D81BAE5131468A838E5D7A243641BFD772E3@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> Sent: 2015?3?2? 17:54
> To: Yang, Wenyou
> Cc: Ferre, Nicolas; mark.rutland at arm.com; devicetree at vger.kernel.org;
> linux at arm.linux.org.uk; pawel.moll at arm.com; ijc+devicetree at hellion.org.uk; linux-
> kernel at vger.kernel.org; robh+dt at kernel.org; galak at codeaurora.org;
> linux at maxim.org.za; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM: dts: at919260/at91sam9g20: fix SRAM device tree
> node
> 
> Hi Wenyou,
> 
> I'd prefer fixing the sram lookup in pm.c. I'll propose something however, I can't
> test on my side.
I can help test it if you give me your patches to me.

> 
> On 02/03/2015 at 14:03:29 +0800, Wenyou Yang wrote :
> > Fix PM does not work on the at91sam9g20ek board
> > --->8---
> > at91_pm_sram_init: failed to find sram device!
> > ---<8---
> >
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> >  arch/arm/boot/dts/at91sam9260.dtsi |    9 +++++++--
> >  arch/arm/boot/dts/at91sam9g20.dtsi |    9 +++++----
> >  2 files changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/at91sam9260.dtsi
> > b/arch/arm/boot/dts/at91sam9260.dtsi
> > index fff0ee6..d1eb27c 100644
> > --- a/arch/arm/boot/dts/at91sam9260.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> > @@ -69,9 +69,14 @@
> >  		};
> >  	};
> >
> > -	sram0: sram at 002ff000 {
> > +	sram0: sram at 00200000 {
> >  		compatible = "mmio-sram";
> > -		reg = <0x002ff000 0x2000>;
> > +		reg = <0x00200000 0x1000>;
> > +	};
> > +
> > +	sram1: sram at 00300000 {
> > +		compatible = "mmio-sram";
> > +		reg = <0x00300000 0x1000>;
> >  	};
> >
> >  	ahb {
> > diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi
> > b/arch/arm/boot/dts/at91sam9g20.dtsi
> > index f593016..eb9a62d 100644
> > --- a/arch/arm/boot/dts/at91sam9g20.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9g20.dtsi
> > @@ -16,13 +16,14 @@
> >  		reg = <0x20000000 0x08000000>;
> >  	};
> >
> > -	sram0: sram at 002ff000 {
> > -		status = "disabled";
> > +	sram0: sram at 00200000 {
> > +		compatible = "mmio-sram";
> > +		reg = <0x00200000 0x4000>;
> >  	};
> >
> > -	sram1: sram at 002fc000 {
> > +	sram1: sram at 00300000 {
> >  		compatible = "mmio-sram";
> > -		reg = <0x002fc000 0x8000>;
> > +		reg = <0x00300000 0x4000>;
> >  	};
> >
> >  	ahb {
> > --
> > 1.7.9.5
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering http://free-electrons.com

Best Regards,
Wenyou Yang
