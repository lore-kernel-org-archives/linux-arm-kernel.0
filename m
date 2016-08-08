From: Wenyou.Yang@microchip.com (Wenyou.Yang at microchip.com)
Date: Mon, 8 Aug 2016 06:05:09 +0000
Subject: [PATCH v3 7/7] doc: bindings: act8945a-charger: Update properties
In-Reply-To: <20160729214020.GA18140@rob-hp-laptop>
References: <1469755528-8413-1-git-send-email-wenyou.yang@atmel.com>
 <1469755528-8413-8-git-send-email-wenyou.yang@atmel.com>
 <20160729214020.GA18140@rob-hp-laptop>
Message-ID: <F9F4555C4E01D7469D37975B62D0EFBB395A8A@CHN-SV-EXMX07.mchp-main.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: 2016?7?30? 5:40
> To: Wenyou Yang <wenyou.yang@atmel.com>
> Cc: Sebastian Reichel <sre@kernel.org>; Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com>; David Woodhouse <dwmw2@infradead.org>; Pawel
> Moll <pawel.moll@arm.com>; Mark Brown <broonie@kernel.org>; Ian Campbell
> <ijc+devicetree@hellion.org.uk>; Kumar Gala <galak@codeaurora.org>; linux-
> kernel at vger.kernel.org; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Nicolas Ferre <nicolas.ferre@atmel.com>; linux-
> pm at vger.kernel.org
> Subject: Re: [PATCH v3 7/7] doc: bindings: act8945a-charger: Update properties
> 
> On Fri, Jul 29, 2016 at 09:25:28AM +0800, Wenyou Yang wrote:
> > Due the driver improvements, update the properties,
> >  - Remove "active-semi,check-battery-temperature" property.
> >  - Add the properties, "active-semi,irq_gpio"
> >    and "active-semi,lbo-gpios".
> >
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> >
> > Changes in v3: None
> > Changes in v2: None
> >
> >  Documentation/devicetree/bindings/power/act8945a-charger.txt | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/power/act8945a-charger.txt
> b/Documentation/devicetree/bindings/power/act8945a-charger.txt
> > index bea254c..d7cf05b 100644
> > --- a/Documentation/devicetree/bindings/power/act8945a-charger.txt
> > +++ b/Documentation/devicetree/bindings/power/act8945a-charger.txt
> > @@ -4,10 +4,12 @@ Required properties:
> >   - compatible: "active-semi,act8945a", please refer to ../mfd/act8945a.txt.
> >   - active-semi,chglev-gpios: charge current level phandle with args
> >     as described in ../gpio/gpio.txt.
> > + - active-semi,irq_gpios: specify the charger interrupt input phanle
> > +   with args as as described in ../gpio/gpio.txt.
> 
> As I said in v2, this should be an interrupt property instead.

Sorry for forgetting to change.

Accepted, will be in next version. Thanks.

> 
> > + - active-semi,lbo-gpios: specify the low battery voltage detect phandle
> > +   with args as as described in ../gpio/gpio.txt.
> 
> Maybe this one too.

The capacity level function need to read this pin level, so this one should not
use "interrupts" property.

> 
> >
> >  Optional properties:
> > - - active-semi,check-battery-temperature: boolean to check the battery
> > -   temperature or not.
> >   - active-semi,input-voltage-threshold-microvolt: unit: mV;
> >     Specifies the charger's input over-voltage threshold value;
> >     The value can be: 6600, 7000, 7500, 8000; default: 6600
> > --
> > 2.7.4
> >

Best Regards,
Wenyou Yang
