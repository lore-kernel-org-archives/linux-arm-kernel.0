From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 11 Oct 2016 10:10:00 +0200
Subject: [PATCH] n900 device tree: cleanup, add camera flash
In-Reply-To: <20161011080139.GK4467@pali>
References: <20161011075416.GA22453@amd>
 <20161011080139.GK4467@pali>
Message-ID: <20161011081000.GA24476@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2016-10-11 10:01:39, Pali Roh?r wrote:
> On Tuesday 11 October 2016 09:54:17 Pavel Machek wrote:
> > @@ -669,6 +670,22 @@
> >  
> >  		ti,usb-charger-detection = <&isp1707>;
> >  	};
> > +
> > +	adp1653: led-controller at 30 {
> > +		compatible = "adi,adp1653";
> > +		reg = <0x30>;
> > +		gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>; /* 88 */
> > +
> > +		flash {
> > +			flash-timeout-us = <500000>;
> > +			flash-max-microamp = <320000>;
> > +			max-microamp = <50000>;
> > +		};
> > +
> > +		indicator {
> > +			max-microamp = <17500>;
> > +		};
> > +	};
> >  };
> >  
> >  &i2c3 {
> > 
> 
> This part of patch is already in mainline kernel, isn't?

Oops, sorry about that. Disregard the patch.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161011/89240514/attachment-0001.sig>
