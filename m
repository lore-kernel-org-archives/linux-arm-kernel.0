From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 01 Sep 2014 12:47:38 +0200
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Enable shmobile platforms
In-Reply-To: <0a6f01cfc432$507900f0$f16b02d0$@samsung.com>
References: <1409234429-1916-1-git-send-email-geert+renesas@glider.be>
 <3598124.ze8sbSR9ui@wuerfel> <0a6f01cfc432$507900f0$f16b02d0$@samsung.com>
Message-ID: <3021375.opancsXhz0@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Saturday, August 30, 2014 06:10:59 PM Kukjin Kim wrote:
> Arnd Bergmann wrote:
> > 
> Hi,
> 
> > On Friday 29 August 2014 20:05:49 Bartlomiej Zolnierkiewicz wrote:
> > > I've been looking lately into making it possible to easily go
> > > from multi_v7_defconfig config to a single platform one (in my
> > > case Exynos one) and removing the need to keep the latter (i.e.
> > > exynos_defconfig) in the kernel tree in the long-term.
> > >
> Why? I don't have any idea why we should use only multi_v7_defconfig for each
> hardware platform. In my understanding, multi_v7_defconfig can be used for one
> kernel image can support all of the platforms but it doesn't mean it should be

In my long-term "plan" both configs should be available but one should
be generated from the other.  Either way should be okay for me: multi ->
single platform or single platforms(s) -> multi.

[ Please note that if you take multi_v7_defconfig and disable support
  for all archs besides Exynos (trivial operation even when done by
  hand) you end up with platform specific kernel config. ]

Pros:
- less code in kernel
- concentrated testing efforts
- configs don't go out-of-sync with each other
- less maintainance burden

Cons:
- fewer config options may be covered than with two independent configs

> used for each platform. And I think, if we cannot maintain each platform's
> defconfig in mainline, it will be kept in each SoC vendor and it is not a good

It seems that currently in case of our internal kernel trees the custom
kernel configs are always used instead of either exynos_defconfig or
multi_v7_defconfig.  I think that there is a big room for improvement
here.

> way. I mean both defconfigs has each value in mainline, exynos_defconfig should
> be updated though ;)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
