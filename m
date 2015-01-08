From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 8 Jan 2015 20:16:03 +0100
Subject: [PATCH v3] ARM: at91/dt: sam9263: Add ac97 device node
In-Reply-To: <2066438.if5qXaBWRu@kongar>
References: <1419854922-29338-1-git-send-email-alexanders83@web.de>
 <1419854922-29338-3-git-send-email-alexanders83@web.de>
 <2066438.if5qXaBWRu@kongar>
Message-ID: <20150108191603.GF2447@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On 08/01/2015 at 20:12:04 +0100, Alexander Stein wrote :
> Now that the implementation has been applied to sound/for-next (https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/log/?h=for-next
> ), who is going to pick the related patches (this one and the other two adding documentation and default config)?
> 

Nicolas will do it but he has not yet started to create a branch for
3.20.

> Best regards,
> Alexander
> 
> On Monday 29 December 2014, 13:08:41 wrote Alexander Stein:
> > This adds the device node for the ac97 controller.
> > 
> > Signed-off-by: Alexander Stein <alexanders83@web.de>
> > Acked-By Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> > Changes in v3:
> > * Renamed the compatible string to atmel,at91sam9263-ac97c
> > * Added 'Acked-By Alexandre Belloni <alexandre.belloni@free-electrons.com>'
> > 
> >  arch/arm/boot/dts/at91sam9263.dtsi | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
> > index 6283785..2e67e38 100644
> > --- a/arch/arm/boot/dts/at91sam9263.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9263.dtsi
> > @@ -700,6 +700,16 @@
> >  					};
> >  				};
> >  
> > +				ac97 {
> > +					pinctrl_ac97: ac97-0 {
> > +						atmel,pins =
> > +							<AT91_PIOB 0 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB12 periph A AC97FS pin */
> > +							 AT91_PIOB 1 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB13 periph A AC97CK pin */
> > +							 AT91_PIOB 2 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB14 periph A AC97TX pin */
> > +							 AT91_PIOB 3 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB14 periph A AC97RX pin */
> > +					};
> > +				};
> > +
> >  				pioA: gpio at fffff200 {
> >  					compatible = "atmel,at91rm9200-gpio";
> >  					reg = <0xfffff200 0x200>;
> > @@ -828,6 +838,17 @@
> >  				status = "disabled";
> >  			};
> >  
> > +			ac97: sound at fffa0000 {
> > +				compatible = "atmel,at91sam9263-ac97c";
> > +				reg = <0xfffa0000 0x4000>;
> > +				interrupts = <18 IRQ_TYPE_LEVEL_HIGH 5>;
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&pinctrl_ac97>;
> > +				clocks = <&ac97_clk>;
> > +				clock-names = "ac97_clk";
> > +				status = "disabled";
> > +			};
> > +
> >  			macb0: ethernet at fffbc000 {
> >  				compatible = "cdns,at32ap7000-macb", "cdns,macb";
> >  				reg = <0xfffbc000 0x100>;
> > 
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
