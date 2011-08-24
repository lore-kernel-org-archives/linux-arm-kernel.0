From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Aug 2011 17:21:52 +0200
Subject: [PATCH 4/4] Move top level platform devices in sysfs to
	/sys/devices/soc/X
In-Reply-To: <CAKnu2Mrzi=mPsHjPePWxyr6Pt5FvBnzFq432SezvgtV+_Jh3Ng@mail.gmail.com>
References: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
	<20110811152239.GB13745@suse.de>
	<CAKnu2Mrzi=mPsHjPePWxyr6Pt5FvBnzFq432SezvgtV+_Jh3Ng@mail.gmail.com>
Message-ID: <201108241721.52908.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 August 2011, Linus Walleij wrote:
> 2011/8/11 Greg KH <gregkh@suse.de>:
> 
> > Ok, if you get guarantees from anyone using the in-kernel platform soc
> > code that this move is acceptable, and you guarantee that no userspace
> > tools will break, that's fine.  But odds are, you are going to break
> > something...
> 
> Yeah I know, but I strongly suspect that these userspace tools are
> created by the same organization that should've consulted me and
> the rest of the community about it in the first place, so I'll cope with
> it and write patches as I get flamed.

Right. Greg, note that the u8500 platform is still only partially supported
upstream, the majority of the necessary device drivers for having a 
running system is not there and those drivers keep getting changed
in order to be merged upstream.

Further, with the move of the platform to device tree based probing,
the position of all devices will change as well, to resemble the physical
HW layout.

	Arnd
