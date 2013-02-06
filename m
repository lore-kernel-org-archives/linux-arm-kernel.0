From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Wed, 6 Feb 2013 01:35:46 +0000
Subject: [v4 PATCH 11/12] ARM: dts: add spi nodes for atmel SoC
In-Reply-To: <20130205195126.GB30595@game.jcrosoft.org>
References: <1358148877-18679-1-git-send-email-wenyou.yang@atmel.com>
 <1358148877-18679-12-git-send-email-wenyou.yang@atmel.com>
 <20130205195126.GB30595@game.jcrosoft.org>
Message-ID: <B256D81BAE5131468A838E5D7A2436413A086C1E@penmbx02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Jean-Christophe PLAGNIOL-VILLARD [mailto:plagnioj at jcrosoft.com]
> Sent: 2013?2?6? 3:51
> To: Yang, Wenyou
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Ferre,
> Nicolas; richard.genoud at gmail.com; Lin, JM; linux at arm.linux.org.uk
> Subject: Re: [v4 PATCH 11/12] ARM: dts: add spi nodes for atmel SoC
> 
> On 15:34 Mon 14 Jan     , Wenyou Yang wrote:
> > From: Richard Genoud <richard.genoud@gmail.com>
> >
> > Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> > [wenyou.yang at atmel.com: add spi nodes for sam9260, sam9263, sam9g45
> and sam9n12]
> > [wenyou.yang at atmel.com: remove spi property "cs-gpios" to the board dts
> files]
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > Cc: linux at arm.linux.org.uk
> > ---
> >  arch/arm/boot/dts/at91sam9260.dtsi |   18 ++++++++++++++++++
> >  arch/arm/boot/dts/at91sam9263.dtsi |   18 ++++++++++++++++++
> >  arch/arm/boot/dts/at91sam9g45.dtsi |   18 ++++++++++++++++++
> I alreadt have some patch in queue
> 
Thanks
I will remove this patch in the next version.

> Best Regards,
> J.
> >  arch/arm/boot/dts/at91sam9n12.dtsi |   18 ++++++++++++++++++
> >  arch/arm/boot/dts/at91sam9x5.dtsi  |   18 ++++++++++++++++++
> >  5 files changed, 90 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/at91sam9260.dtsi
> b/arch/arm/boot/dts/at91sam9260.dtsi
> > index 68bccf4..9586fe1 100644
> > --- a/arch/arm/boot/dts/at91sam9260.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> > @@ -453,6 +453,24 @@
> >  				status = "disabled";
> >  			};
> >
> > +			spi0: spi at fffc8000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9260-spi";
> > +				reg = <0xfffc8000 0x200>;
> > +				interrupts = <12 4 3>;
> > +				status = "disabled";
> > +			};
> > +
> > +			spi1: spi at fffcc000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9260-spi";
> > +				reg = <0xfffcc000 0x200>;
> > +				interrupts = <13 4 3>;
> > +				status = "disabled";
> > +			};
> > +
> >  			adc0: adc at fffe0000 {
> >  				compatible = "atmel,at91sam9260-adc";
> >  				reg = <0xfffe0000 0x100>;
> > diff --git a/arch/arm/boot/dts/at91sam9263.dtsi
> b/arch/arm/boot/dts/at91sam9263.dtsi
> > index 32ec62c..636b882 100644
> > --- a/arch/arm/boot/dts/at91sam9263.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9263.dtsi
> > @@ -426,6 +426,24 @@
> >  				reg = <0xfffffd40 0x10>;
> >  				status = "disabled";
> >  			};
> > +
> > +			spi0: spi at fffa4000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9260-spi";
> > +				reg = <0xfffa4000 0x200>;
> > +				interrupts = <14 4 3>;
> > +				status = "disabled";
> > +			};
> > +
> > +			spi1: spi at fffa8000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9260-spi";
> > +				reg = <0xfffa8000 0x200>;
> > +				interrupts = <15 4 3>;
> > +				status = "disabled";
> > +			};
> >  		};
> >
> >  		nand0: nand at 40000000 {
> > diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi
> b/arch/arm/boot/dts/at91sam9g45.dtsi
> > index 231858f..0100b80 100644
> > --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> > @@ -495,6 +495,24 @@
> >  				reg = <0xfffffd40 0x10>;
> >  				status = "disabled";
> >  			};
> > +
> > +			spi0: spi at fffa4000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9g45-spi";
> > +				reg = <0xfffa4000 0x200>;
> > +				interrupts = <14 4 3>;
> > +				status = "disabled";
> > +			};
> > +
> > +			spi1: spi at fffa8000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9g45-spi";
> > +				reg = <0xfffa8000 0x200>;
> > +				interrupts = <15 4 3>;
> > +				status = "disabled";
> > +			};
> >  		};
> >
> >  		nand0: nand at 40000000 {
> > diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi
> b/arch/arm/boot/dts/at91sam9n12.dtsi
> > index e9efb34..86d5357 100644
> > --- a/arch/arm/boot/dts/at91sam9n12.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> > @@ -355,6 +355,24 @@
> >  				#size-cells = <0>;
> >  				status = "disabled";
> >  			};
> > +
> > +			spi0: spi at f0000000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9x5-spi";
> > +				reg = <0xf0000000 0x100>;
> > +				interrupts = <13 4 3>;
> > +				status = "disabled";
> > +			};
> > +
> > +			spi1: spi at f0004000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9x5-spi";
> > +				reg = <0xf0004000 0x100>;
> > +				interrupts = <14 4 3>;
> > +				status = "disabled";
> > +			};
> >  		};
> >
> >  		nand0: nand at 40000000 {
> > diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi
> b/arch/arm/boot/dts/at91sam9x5.dtsi
> > index 40ac3a4..8ea2f7d 100644
> > --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> > @@ -473,6 +473,24 @@
> >  					trigger-value = <0x6>;
> >  				};
> >  			};
> > +
> > +			spi0: spi at f0000000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9x5-spi";
> > +				reg = <0xf0000000 0x100>;
> > +				interrupts = <13 4 3>;
> > +				status = "disabled";
> > +			};
> > +
> > +			spi1: spi at f0004000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9x5-spi";
> > +				reg = <0xf0004000 0x100>;
> > +				interrupts = <14 4 3>;
> > +				status = "disabled";
> > +			};
> >  		};
> >
> >  		nand0: nand at 40000000 {
> > --
> > 1.7.9.5
> >

Best Regards,
Wenyou Yang
