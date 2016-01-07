From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 7 Jan 2016 12:34:09 +0100
Subject: Nokia N900: u-SD card in v4.2+
In-Reply-To: <568DFA4B.7030308@ti.com>
References: <20160106204627.GA21477@amd>
 <568DFA4B.7030308@ti.com>
Message-ID: <20160107113408.GA26618@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> On Thursday 07 January 2016 02:16 AM, Pavel Machek wrote:
> > Hi!
> > 
> > In v4.1, both internal MMC and u-SD cards work ok.
> > 
> > In v4.2, only the internal MMC is detected. In v4.3, not even internal
> > MMC works. In v4.4, only the internal MMC is detected.
> > 
> > Does it work for you? Any patches?
> 
> I don't have Nokia N900 to check this, but can you share your config and kernel
> logs? Check if CONFIG_REGULATOR_PBIAS is present in your config.
> CONFIG_REGULATOR_PBIAS is now mandatory for all omap3+ SoCs to work.

I enabled CONFIG_REGULATOR_PBIAS and both MMCs now work.

I wonder if we should add some selects, so that users updating from
old kernels don't break their system?

Thanks,
									
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
