From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 1 Aug 2018 20:58:24 +0200
Subject: Vibrations on Droid 4?
In-Reply-To: <20180716075926.GU99251@atomide.com>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd> <20180711132739.GL99251@atomide.com>
 <20180715201729.GB19675@amd> <20180716075926.GU99251@atomide.com>
Message-ID: <20180801185823.GC26087@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Yep, so I have two patches that make the device appear, but vibrations
> > still do not work for me.
> > 
> > a) any ideas how to debug that / get them to work?
> 
> Hmm no new ideas except I wonder if there is also some other
> regression with the timer pdata not being passed properly now.

I checked vibrations work in original Motorola Android; my hardware is
not broken.

I see:

commit b7290cf6ff7869ec12070aa146c370728cab62c2
Author: Keerthy <j-keerthy@ti.com>
Date:   Thu Feb 15 11:31:50 2018 +0530

    pwm: pwm-omap-dmtimer: Adapt driver to utilize dmtimer pdata ops

    Adapt driver to utilize dmtimer pdata ops instead of pdata-quirks.

 Signed-off-by: Keerthy <j-keerthy@ti.com>
 Acked-by: Neil Armstrong <narmstrong@baylibre.com>
 Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
 Signed-off-by: Tony Lindgren <tony@atomide.com>
		
should I try to revert that one? (Are pdata still there in the board
files somewhere).

Do vibrations work for you?

Best regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180801/6f4562f7/attachment.sig>
