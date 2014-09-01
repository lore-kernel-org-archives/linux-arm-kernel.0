From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Sep 2014 10:58:19 +0200
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Enable shmobile platforms
In-Reply-To: <0a6f01cfc432$507900f0$f16b02d0$@samsung.com>
References: <1409234429-1916-1-git-send-email-geert+renesas@glider.be>
 <3598124.ze8sbSR9ui@wuerfel> <0a6f01cfc432$507900f0$f16b02d0$@samsung.com>
Message-ID: <7714045.KMII2MK3EF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 30 August 2014 18:10:59 Kukjin Kim wrote:
> Arnd Bergmann wrote:
> > On Friday 29 August 2014 20:05:49 Bartlomiej Zolnierkiewicz wrote:
> > > I've been looking lately into making it possible to easily go
> > > from multi_v7_defconfig config to a single platform one (in my
> > > case Exynos one) and removing the need to keep the latter (i.e.
> > > exynos_defconfig) in the kernel tree in the long-term.
> > >
> Why? I don't have any idea why we should use only multi_v7_defconfig for each
> hardware platform. In my understanding, multi_v7_defconfig can be used for one
> kernel image can support all of the platforms but it doesn't mean it should be
> used for each platform. And I think, if we cannot maintain each platform's
> defconfig in mainline, it will be kept in each SoC vendor and it is not a good
> way. I mean both defconfigs has each value in mainline, exynos_defconfig should
> be updated though ;)

It's not clear how we are going to do this in the long run. We definitely
have far more defconfig files in the kernel than we want to have, it's
a burden for testers. In theory, running multi_v7_defconfig should have
no downsides other than the obvious space overhead of the unused platform
code and there should be no difference between disabling unused file systems
and PCI drivers to disabling unused platforms.

Another argument is that even an exynos_defconfig contains much more
code than you really want, and for an embedded system you would turn off
all the drivers that a particular exynos machine does not have. So there
is no fundamental difference between turning off part of exynos_defconfig
and turning off parts of multi_v7_defconfig, the difference is mainly
how many options you'd turn off.

Then again, I also don't see a reason to remove exynos_defconfig any time
soon. So far the rule is that each platform can have its own defconfig
because that's the way it has been done for a long time.

	Arnd
