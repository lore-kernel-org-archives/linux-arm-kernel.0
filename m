From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 8 Aug 2018 19:09:33 +0200
Subject: Vibrations on Droid 4?
In-Reply-To: <20180802110701.3b4voigegy67h4p5@earth.universe>
References: <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd> <20180711132739.GL99251@atomide.com>
 <20180715201729.GB19675@amd> <20180716075926.GU99251@atomide.com>
 <20180801185823.GC26087@amd>
 <20180802110701.3b4voigegy67h4p5@earth.universe>
Message-ID: <20180808170933.GC7306@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> On Wed, Aug 01, 2018 at 08:58:24PM +0200, Pavel Machek wrote:
> > > > Yep, so I have two patches that make the device appear, but vibrations
> > > > still do not work for me.
> > > > 
> > > > a) any ideas how to debug that / get them to work?
> > > 
> > > Hmm no new ideas except I wonder if there is also some other
> > > regression with the timer pdata not being passed properly now.
> > 
> > I checked vibrations work in original Motorola Android; my hardware is
> > not broken.
> 
> You got it working, but this information might still be interesting
> in case of future problems:
> 
> The Android "driver" is very different from the one I wrote from
> scratch and upstreamed. The mainline driver is less lines of code
> (iirc 25%), less complicated (Android vibration support is spread
> over multiple drivers/arch code), more efficient (Android drivers
> does GPIO bitbanging instead of PWM) and provides more features
> (Android driver does not allow all strength settings). Also it uses
> normal input device API instead of a custom one.

Thanks for doing it right.

> P.S.: Sorry, I don't have much time to work on D4 at the moment :(

Thanks for doing the work, d4 seems to be the most usable phone at the
moment. Yes, there's more work to do, but there's always more work to
do.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180808/13330542/attachment.sig>
