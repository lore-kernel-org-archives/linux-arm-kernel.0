From: marvin24@gmx.de (Marc Dietrich)
Date: Wed, 27 Feb 2013 10:03:03 +0100
Subject: Multi-platform, and secure-only ARM errata workarounds
In-Reply-To: <512CE533.6020005@wwwdotorg.org>
References: <512BF81A.3080700@wwwdotorg.org>
 <4928288.ie8EUukfVD@fb07-iapwap2.physik.uni-giessen.de>
 <512CE533.6020005@wwwdotorg.org>
Message-ID: <22709540.96uJddbx1U@fb07-iapwap2.physik.uni-giessen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 26. Februar 2013, 09:39:15 schrieb Stephen Warren:
> On 02/26/2013 02:36 AM, Marc Dietrich wrote:
> > Am Montag, 25. Februar 2013, 16:47:38 schrieb Stephen Warren:
> >> ...
> >> Now, I can easily add those 3 errata workarounds to U-Boot, but that
> >> will require people to reflash their bootloader. This is probably
> >> acceptable for development/reference boards (although I'm sure people
> >> will find it annoying) but for re-purposed production boards (such as
> >> the Toshiba AC100 or various tablets) it will be impossible to update
> >> the factory bootloader. Switching to upstream U-Boot would currently
> >> lose some functionality, and significantly affect people's boot flow, so
> >> is likely unacceptable.
> > 
> > personally, I have no problem to require a certain u-boot version for a
> > given kernel. From a distro point of view, you will likely update the
> > bootloader/kernel on a distro update anyway.
> 
> So a distro will certainly update the kernel.
> 
> But updating a bootloader would be very unusual, I believe.

mmh? Every time I update to a new distro release, the bootloader gets also 
updated - even on arm, e.g. ftp://ports.ubuntu.com/ubuntu-ports/pool/main/u/u-boot-linaro lists four version of uboot - one for each supported distro 
release. I know for closed embedded device this is different, but that's not 
our target.

> Also, I hope that upstream U-Boot is never going to support the bizarre
> "Tegra partition table" cruft that our "fastboot" bootloader supports,
> so you'll end up completely re-programming the flash (BCT, bootloader,
> partition table, all filesystems) if you want to switch to U-Boot. That
> seems like a fair chunk for the installer to own, but I guess if you're
> comfortable with doing that, I won't complain.

Yes, that a huge pile of work and people are working on this already. One the 
other hand, why (if not for upgrade use) do we have u-boot support for all 
these legacy boards?

Marc
