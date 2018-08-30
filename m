From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 30 Aug 2018 22:18:25 +0200
Subject: [rfc] leds: add TI LMU backlight driver
In-Reply-To: <a0906253-44e3-5a01-73ca-67c7cb124eb0@ti.com>
References: <20180829212032.GB15786@amd>
 <a0906253-44e3-5a01-73ca-67c7cb124eb0@ti.com>
Message-ID: <20180830201825.GA1936@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Here's preview of driver for TI LMU. It controls LEDs on Droid 4
> > smartphone, including keyboard and screen backlights.
> > 
> > This adds backlight support for the following TI LMU
> > chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
> > 
> > Signed-off-by: Milo Kim <milo.kim@ti.com>
> > [add LED subsystem support for keyboard backlight and rework DT
> > binding according to Rob Herrings feedback]
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > [remove backlight subsystem support for now]
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > 
> > ---
> > 
> > Does it looks mostly reasonable? I guess it will need some
> > s/BACKLIGHT/LEDS/ , and I'll need to remove my debugging hacks.
> > 
> > I'd prefer this to be LED driver, first; I'll need to figure out what
> > to do with backlight. I guess something like existing "backlight"
> > trigger should do the trick.
> > 
> 
> I looked at this driver from Milo before submitting a specific LM3697 driver.

Aha. I did not realize that was for same hardware... I should have
cc-ed you, I guess.

> I do not like this driver.
> I don't like that it smashes numerous devices into some structure with varying register maps.
>

Can you elaborate? The chips are similar enough that single driver
makes sense, and we certainly want to maintain one driver, not 6
drivers differing only in .. what exactly?

> Not only that but it appears that you just pulled this driver from a repo and posted it without clean up.
> 

a) No I did not, feel free to generate a diff.

b) Even if I did, why would that be a problem?

> If the devices share register maps and can be added to families I would prefer to do it that way.
> 
> So if the LM3695 and LM3697 share the same features and register map they should be one driver
> The LM363x series may be able to be a different driver.

Well all 6 chips this driver supports seem to be similar enough, so
that single driver makes sense.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180830/31f5014c/attachment.sig>
