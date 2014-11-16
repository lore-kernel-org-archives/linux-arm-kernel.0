From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 16 Nov 2014 11:15:48 +0100
Subject: [RFC] adp1653: Add device tree bindings for LED controller
In-Reply-To: <546877EF.8010906@suse.de>
References: <20141116075928.GA9763@amd>
 <546877EF.8010906@suse.de>
Message-ID: <20141116101548.GB32483@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2014-11-16 11:09:51, Andreas F?rber wrote:
> Hi Pavel,
> 
> Am 16.11.2014 um 08:59 schrieb Pavel Machek:
> > For device tree people: Yes, I know I'll have to create file in
> > documentation, but does the binding below look acceptable?
> [...]
> > diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> > index 739fcf2..ed0bfc1 100644
> > --- a/arch/arm/boot/dts/omap3-n900.dts
> > +++ b/arch/arm/boot/dts/omap3-n900.dts
> > @@ -553,6 +561,18 @@
> >  
> >  		ti,usb-charger-detection = <&isp1704>;
> >  	};
> > +
> > +	adp1653: adp1653 at 30 {
> 
> This should probably be led-controller at 30 (a generic description not
> specific to the model). The label name is fine.

Thanks.

> > +		gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>; /* Want 88 */
> 
> At least to me, the meaning of "Want 88" is not clear - drop or clarify?

I changed it to /* 88 */ to match rest of code.

Best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
