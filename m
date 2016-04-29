From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 29 Apr 2016 09:15:26 +0200
Subject: v4l subdevs without big device was Re: drivers/media/i2c/adp1653.c:
 does not show as /dev/video* or v4l-subdev*
In-Reply-To: <20160428084546.GA9957@amd>
References: <20160428084546.GA9957@amd>
Message-ID: <20160429071525.GA4823@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> On n900, probe finishes ok (verified by adding printks), and the
> device shows up in /sys, but I  don't get /dev/video* or
> /dev/v4l-subdev*.
> 
> Other drivers (back and front camera) load ok, and actually work. Any
> idea what could be wrong?

Ok, so I guess I realized what is the problem:

adp1653 registers itself as a subdev, but there's no device that
register it as its part.

(ad5820 driver seems to have the same problem).

Is there example "dummy" device I could use, for sole purpose of
having these devices appear in /dev? They are on i2c, so both can work
on their own.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
