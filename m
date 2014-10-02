From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Oct 2014 17:44:48 +0200
Subject: [GIT PULL] arm64, thunder: Enable Cavium Thunder SoC Family
In-Reply-To: <20141002144452.GO20170@rric.localhost>
References: <1410544187-15876-1-git-send-email-rric@kernel.org>
 <20141002072938.GM20170@rric.localhost>
 <20141002144452.GO20170@rric.localhost>
Message-ID: <10758908.VF9CYFtfmA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 October 2014 16:44:52 Robert Richter wrote:
> The following changes since commit 9e82bf014195d6f0054982c463575cdce24292be:
> 
>   Linux 3.17-rc5 (2014-09-14 17:50:12 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rric/linux.git tags/for-arm-soc-v3.18
> 
> for you to fetch changes up to 1200e87a26b6b4fe1f473267c83515117e08ee39:
> 
>   arm64, defconfig: Enable Cavium Thunder SoC in defconfig (2014-09-23 15:10:55 +0200)
> 
> ----------------------------------------------------------------
> Enablement patches for Cavium Thunder SoC Family. The patches add
> devicetree and Kconfig support and then add Thunder to the defconfig.

I've pulled them into a new next/arm64 branch in the arm-soc tree,
but noticed that you had based them on top of -rc5. If you have no
strong reasons to pick a newer -rc, it's better to base on top of
-rc1, to save us trouble with backmerges.

I ended up rebasing to -rc1, since you gave the option to apply the
patches directly.

I originally missed the patches because they were not sent to
arm at kernel.org but only to our personal addresses. Please include
the arm at kernel.org address whenever you want patches or pull requests
to get applied (as opposed to reviewed). We are not really taking
new code for arm-soc any more, but this one was first submitted
for inclusion a while back, so I'm making an exception.

Finally, I also wanted to pull your "dts, kbuild: Implement support
for dtb vendor subdirs", but that clearly conflicts with this series,
and I decided not to pull that and take this one instead.

I'm guessing we'd see conflicts with other patches in linux-next,
so I'd rather not do the merge any more now, we can take that one
for 3.19.

	Arnd
