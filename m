From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 18 Jan 2018 23:03:48 +0100
Subject: [PATCH] Nokia N9: add support for up/down keys in the dts
In-Reply-To: <20180102194236.ahrhkvnefre2l6gf@earth.universe>
References: <20180102125948.GA20051@amd>
 <20180102194236.ahrhkvnefre2l6gf@earth.universe>
Message-ID: <20180118220348.GD17196@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2018-01-02 20:42:36, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Jan 02, 2018 at 01:59:48PM +0100, Pavel Machek wrote:
> > 
> > This adds support for volume up/down keys in the dts.
> > 
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Tony, ping? Can I get you to apply this one?

[PATCHv2] nokia N9: Add support for magnetometer

should be good to go, too...
									Pavel
									

> > diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
> > index 39e35f8..57a6679 100644
> > --- a/arch/arm/boot/dts/omap3-n9.dts
> > +++ b/arch/arm/boot/dts/omap3-n9.dts
> > @@ -11,9 +11,10 @@
> >  /dts-v1/;
> >  
> >  #include "omap3-n950-n9.dtsi"
> > +#include <dt-bindings/input/input.h>
> >  
> >  / {
> >  	model = "Nokia N9";
> >  	compatible = "nokia,omap3-n9", "ti,omap36xx", "ti,omap3";
> >  };
> >  
> > @@ -72,3 +133,9 @@
> >  	st,max-limit-y = <46>;
> >  	st,max-limit-z = <46>;
> >  };
> > +
> > +&twl_keypad {
> > +	linux,keymap = < MATRIX_KEY(6, 8, KEY_VOLUMEUP)
> > +			 MATRIX_KEY(7, 8, KEY_VOLUMEDOWN)
> > +			 >;
> > +};
> > 
> > 
> > -- 
> > (english) http://www.livejournal.com/~pavelmachek
> > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> 
> 



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180118/8963ae25/attachment.sig>
