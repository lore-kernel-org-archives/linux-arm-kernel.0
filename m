From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Fri, 7 Dec 2012 01:34:01 +0000
Subject: [v2 PATCH 13/14] ARM: dts: add spi nodes for atmel SoC
In-Reply-To: <50C0C9C9.9000108@atmel.com>
References: <1354607640-13229-1-git-send-email-wenyou.yang@atmel.com>
 <1354607640-13229-14-git-send-email-wenyou.yang@atmel.com>
 <50C0C9C9.9000108@atmel.com>
Message-ID: <B256D81BAE5131468A838E5D7A2436413A01DEF5@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ludovic,

> -----Original Message-----
> From: Desroches, Ludovic
> Sent: 2012?12?7? 0:37
> To: Yang, Wenyou
> Cc: linux-arm-kernel at lists.infradead.org; linux at arm.linux.org.uk;
> richard.genoud at gmail.com; Lin, JM; Ferre, Nicolas; linux-kernel at vger.kernel.org;
> plagnioj at jcrosoft.com; Desroches, Ludovic
> Subject: Re: [v2 PATCH 13/14] ARM: dts: add spi nodes for atmel SoC
> 
> Hi,
> 
> On 12/04/2012 08:53 AM, Wenyou Yang wrote:
> > From: Richard Genoud <richard.genoud@gmail.com>
> >
> > Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> > [wenyou.yang at atmel.com: add spi nodes for other atmel SOC]
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > Cc: linux at arm.linux.org.uk
> > ---
> >   arch/arm/boot/dts/at91sam9260.dtsi |   30
> ++++++++++++++++++++++++++++++
> >   arch/arm/boot/dts/at91sam9263.dtsi |   30
> ++++++++++++++++++++++++++++++
> >   arch/arm/boot/dts/at91sam9g45.dtsi |   30
> ++++++++++++++++++++++++++++++
> >   arch/arm/boot/dts/at91sam9n12.dtsi |   30
> ++++++++++++++++++++++++++++++
> >   arch/arm/boot/dts/at91sam9x5.dtsi  |   30
> ++++++++++++++++++++++++++++++
> >   5 files changed, 150 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/at91sam9260.dtsi
> b/arch/arm/boot/dts/at91sam9260.dtsi
> > index d410581..87254aa 100644
> > --- a/arch/arm/boot/dts/at91sam9260.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> > @@ -212,6 +212,36 @@
> >   				status = "disabled";
> >   			};
> >
> > +			spi0: spi at fffc8000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9260-spi";
> > +				reg = <0xfffc8000 0x200>;
> > +				interrupts = <12 4 3>;
> > +				cs-gpios = <&pioA 3 0
> > +					    &pioC 11 0
> > +					    &pioC 16 0
> > +					    &pioC 17 0
> > +					   >;
> 
>  From my point of view, the cs-gpios stuff should be in board dts files
> instead of the SoC dtsi file.
> 
> These pios can be shared with other devices. If only one chip select
> gpio is used on the board, it could avoid some useless pin conflicts.
> 
Thanks
These pins are defined as CS0, CS1, CS2 and CS3 for SoC. it is selected for the board.
And it will not be configured unless it is selected. So it doesn't cause pin conficts.

> Regards
> 
> Ludovic
>
Best Regards,
Wenyou Yang
 
> > +				dma-mask = <0xffffffff>;
> > +				status = "disabled";
> > +			};
> > +
> > +			spi1: spi at fffcc000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9260-spi";
> > +				reg = <0xfffcc000 0x200>;
> > +				interrupts = <13 4 3>;
> > +				cs-gpios = <&pioB 3 0
> > +					    &pioC 5 0
> > +					    &pioC 4 0
> > +					    &pioC 3 0
> > +					   >;
> > +				dma-mask = <0xffffffff>;
> > +				status = "disabled";
> > +			};
> > +
> >   			adc0: adc at fffe0000 {
> >   				compatible = "atmel,at91sam9260-adc";
> >   				reg = <0xfffe0000 0x100>;
> > diff --git a/arch/arm/boot/dts/at91sam9263.dtsi
> b/arch/arm/boot/dts/at91sam9263.dtsi
> > index 3e6e5c1..528395d 100644
> > --- a/arch/arm/boot/dts/at91sam9263.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9263.dtsi
> > @@ -195,6 +195,36 @@
> >   				#size-cells = <0>;
> >   				status = "disabled";
> >   			};
> > +
> > +			spi0: spi at fffa4000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9260-spi";
> > +				reg = <0xfffa4000 0x200>;
> > +				interrupts = <14 4 3>;
> > +				cs-gpios = <&pioA 5 0
> > +					    &pioA 3 0
> > +					    &pioA 4 0
> > +					    &pioB 11 0
> > +					   >;
> > +				dma-mask = <0xffffffff>;
> > +				status = "disabled";
> > +			};
> > +
> > +			spi1: spi at fffa8000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9260-spi";
> > +				reg = <0xfffa8000 0x200>;
> > +				interrupts = <15 4 3>;
> > +				cs-gpios = <&pioB 15 0
> > +					    &pioB 16 0
> > +					    &pioB 17 0
> > +					    &pioB 18 0
> > +					   >;
> > +				dma-mask = <0xffffffff>;
> > +				status = "disabled";
> > +			};
> >   		};
> >
> >   		nand0: nand at 40000000 {
> > diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi
> b/arch/arm/boot/dts/at91sam9g45.dtsi
> > index 3add030..8a6aae92 100644
> > --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> > @@ -262,6 +262,36 @@
> >   					trigger-value = <0x6>;
> >   				};
> >   			};
> > +
> > +			spi0: spi at fffa4000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9260-spi";
> > +				reg = <0xfffa4000 0x200>;
> > +				interrupts = <14 4 3>;
> > +				cs-gpios = <&pioB 3 0
> > +					    &pioB 18 0
> > +					    &pioB 19 0
> > +					    &pioD 27 0
> > +					   >;
> > +				dma-mask = <0xffffffff>;
> > +				status = "disabled";
> > +			};
> > +
> > +			spi1: spi at fffa8000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9260-spi";
> > +				reg = <0xfffa8000 0x200>;
> > +				interrupts = <15 4 3>;
> > +				cs-gpios = <&pioB 17 0
> > +					    &pioD 28 0
> > +					    &pioD 18 0
> > +					    &pioD 19 0
> > +					   >;
> > +				dma-mask = <0xffffffff>;
> > +				status = "disabled";
> > +			};
> >   		};
> >
> >   		nand0: nand at 40000000 {
> > diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi
> b/arch/arm/boot/dts/at91sam9n12.dtsi
> > index 82508d6..183cacf 100644
> > --- a/arch/arm/boot/dts/at91sam9n12.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> > @@ -202,6 +202,36 @@
> >   				#size-cells = <0>;
> >   				status = "disabled";
> >   			};
> > +
> > +			spi0: spi at f0000000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9x5-spi";
> > +				reg = <0xf0000000 0x100>;
> > +				interrupts = <13 4 3>;
> > +				cs-gpios = <&pioA 14 0
> > +					    &pioA 7 0
> > +					    &pioA 1 0
> > +					    &pioB 3 0
> > +					   >;
> > +				dma-mask = <0xffffffff>;
> > +				status = "disabled";
> > +			};
> > +
> > +			spi1: spi at f0004000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9x5-spi";
> > +				reg = <0xf0004000 0x100>;
> > +				interrupts = <14 4 3>;
> > +				cs-gpios = <&pioA 8 0
> > +					    &pioA 0 0
> > +					    &pioA 31 0
> > +					    &pioA 30 0
> > +					   >;
> > +				dma-mask = <0xffffffff>;
> > +				status = "disabled";
> > +			};
> >   		};
> >
> >   		nand0: nand at 40000000 {
> > diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi
> b/arch/arm/boot/dts/at91sam9x5.dtsi
> > index 03fc136..95b55fd 100644
> > --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> > @@ -263,6 +263,36 @@
> >   					trigger-value = <0x6>;
> >   				};
> >   			};
> > +
> > +			spi0: spi at f0000000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9x5-spi";
> > +				reg = <0xf0000000 0x100>;
> > +				interrupts = <13 4 3>;
> > +				cs-gpios = <&pioA 14 0
> > +					    &pioA 7 0 /* conflicts with TXD2 */
> > +					    &pioA 1 0 /* conflicts with RXD0 */
> > +					    &pioB 3 0 /* conflicts with ERXDV */
> > +					   >;
> > +				dma-mask = <0xffffffff>;
> > +				status = "disabled";
> > +			};
> > +
> > +			spi1: spi at f0004000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "atmel,at91sam9x5-spi";
> > +				reg = <0xf0004000 0x100>;
> > +				interrupts = <14 4 3>;
> > +				cs-gpios = <&pioA 8 0 /* conflitcs with RXD2 */
> > +					    &pioA 0 0 /* conflitcs with TXD0 */
> > +					    &pioA 31 0 /* conflitcs with TWCK0 */
> > +					    &pioA 30 0 /* conflitcs with TWD0 */
> > +					   >;
> > +				dma-mask = <0xffffffff>;
> > +				status = "disabled";
> > +			};
> >   		};
> >
> >   		nand0: nand at 40000000 {
> >
