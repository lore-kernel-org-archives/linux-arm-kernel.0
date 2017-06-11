From: jic23@jic23.retrosnub.co.uk (Jonathan Cameron)
Date: Sun, 11 Jun 2017 12:25:20 +0100
Subject: [PATCH v4 2/4] Documentation: dt: iio: at91-sama5d2_adc: add hw
 trigger edge binding
In-Reply-To: <20170611122413.20008d30@kernel.org>
References: <1496992039-17964-1-git-send-email-eugen.hristev@microchip.com>
 <1496992039-17964-3-git-send-email-eugen.hristev@microchip.com>
 <20170611122413.20008d30@kernel.org>
Message-ID: <20170611122520.2a72c37b@jic23.retrosnub.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 11 Jun 2017 12:24:13 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 9 Jun 2017 10:07:17 +0300
> Eugen Hristev <eugen.hristev@microchip.com> wrote:
> 
> > Add property for the edge type of the hardware trigger pin ADTRG
> > 
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>  
> Hi Eugen,
> 
> CC the device tree maintainers and list for devicetree binding changes.
> 
> I've added them.   This one is unusual enough it will need and Ack from
> that direction (and I prefer to get them even for the trivial patches
> when Rob and Mark aren't too busy!)
Sorry, I missed that you had cc'd the list - just noticed it in the
next patch and thought that was odd!

Anyhow, good work - we'll just wait for them to have a chance to look
at it :)
> 
> Jonathan
> > ---
> >   Changes in v4:
> >  - Modified bindings to be similar with interrupts
> > 
> >  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> > index 3223684..552e7a8 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> > +++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> > @@ -11,6 +11,11 @@ Required properties:
> >    - atmel,min-sample-rate-hz: Minimum sampling rate, it depends on SoC.
> >    - atmel,max-sample-rate-hz: Maximum sampling rate, it depends on SoC.
> >    - atmel,startup-time-ms: Startup time expressed in ms, it depends on SoC.
> > +  - atmel,trigger-edge-type: One of possible edge types for the ADTRG hardware
> > +  trigger pin. When the specific edge type is detected, the conversion will
> > +  start. Possible values are rising, falling, or both.
> > +  This property uses the IRQ edge types values: IRQ_TYPE_EDGE_RISING ,
> > +  IRQ_TYPE_EDGE_FALLING or IRQ_TYPE_EDGE_BOTH
> >  
> >  Example:
> >  
> > @@ -25,4 +30,5 @@ adc: adc at fc030000 {
> >  	atmel,startup-time-ms = <4>;
> >  	vddana-supply = <&vdd_3v3_lp_reg>;
> >  	vref-supply = <&vdd_3v3_lp_reg>;
> > +	atmel,trigger-edge-type = <IRQ_TYPE_EDGE_BOTH>;
> >  }  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
