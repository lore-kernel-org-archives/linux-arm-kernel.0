From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 8 Jun 2016 12:33:00 +0200
Subject: [PATCH v3 2/2] ARM: at91/dt: sama5d2: Use new compatible for
 ohci node
In-Reply-To: <5757EE13.1080107@atmel.com>
References: <1465359311-14544-1-git-send-email-wenyou.yang@atmel.com>
 <1465359311-14544-3-git-send-email-wenyou.yang@atmel.com>
 <5757EE13.1080107@atmel.com>
Message-ID: <20160608103300.GE2466@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2016 at 12:06:11 +0200, Nicolas Ferre wrote :
> Le 08/06/2016 06:15, Wenyou Yang a ?crit :
> > Use compatible "atmel,sama5d2-ohci" to be capable of suspending
> > ports while sleep to save the power consumption.
> > 
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> > 
> > Changes in v3: None
> > Changes in v2:
> >  - Use the new compatible for ohci-node.
> > 
> >  arch/arm/boot/dts/sama5d2.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> > index 78996bd..03d6724 100644
> > --- a/arch/arm/boot/dts/sama5d2.dtsi
> > +++ b/arch/arm/boot/dts/sama5d2.dtsi
> > @@ -232,7 +232,7 @@
> >  		};
> >  
> >  		usb1: ohci at 00400000 {
> > -			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
> > +			compatible = "atmel,sama5d2-ohci", "usb-ohci";
> 
> We must change this to:
> +			compatible = "atmel,sama5d2-ohci", "atmel,at91rm9200-ohci", "usb-ohci";
> 
> To make it independent from the one that may reach Mainline through the USB git tree.
> 

Well, like discussed, I'd say that a new compatible is not needed as we
already know on which chip we are running depending on the SFR that we
can lookup. My concern was only to avoid calling a function
unnecessarily on !sama5d2 platforms.
> 
> >  			reg = <0x00400000 0x100000>;
> >  			interrupts = <41 IRQ_TYPE_LEVEL_HIGH 2>;
> >  			clocks = <&uhphs_clk>, <&uhphs_clk>, <&uhpck>;
> > 
> 
> Bye,
> -- 
> Nicolas Ferre

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
