From: pavel@denx.de (Pavel Machek)
Date: Tue, 26 Aug 2014 12:19:24 +0200
Subject: [PATCHv10 0/5] ARM: remove the sub-node and deprecate
 supports-highspeed property for dwmmc.
In-Reply-To: <53FB2807.7070503@samsung.com>
References: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
 <20140825112151.GA21336@amd> <53FB1DD5.3050207@samsung.com>
 <20140825113719.GA31960@amd> <53FB278B.7010509@samsung.com>
 <53FB2807.7070503@samsung.com>
Message-ID: <20140826101923.GA13619@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> Would you elaborate?
> >>
> >> If I have a device like a phone, I may want to put one "slot" inside
> >> phone for basic system, and offer second slot for user expansion
> >> (initially empty).
> > 
> > if multiple slot is supported, then a mmcqd should be processing for multiple slots.
> > It's too inefficient, and affect the whole performance reduction.
> Sorry, Discard this comment. it means dwmci, not mmcqd.

Well, that's a Linux problem, and for many applications, not even
problem at all.

Device tree should describe hardware, and hardware can do multiple
slots per controller, so device tree should describe multiple slots
per controller.

Now, the configuration may be uncommon, but you are moving from good
hardware description to bad hardware description.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
