From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 04 Sep 2014 12:16:57 +0200
Subject: [PATCH 18/19] ARM: SAMSUNG: Remove remaining legacy code
In-Reply-To: <53C676DB.6070002@samsung.com>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
 <1404496099-26708-19-git-send-email-t.figa@samsung.com>
 <1405505756.4408.24.camel@x220> <53C676DB.6070002@samsung.com>
Message-ID: <1409825817.5546.99.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-07-16 at 14:58 +0200, Tomasz Figa wrote:
> On 16.07.2014 12:15, Paul Bolle wrote:
> > After this patch that symbol is still referenced in:
> > drivers/media/platform/Kconfig:159:     depends on VIDEO_DEV && VIDEO_V4L2 && (PLAT_S5P || ARCH_EXYNOS)
> > drivers/media/platform/Kconfig:169:     depends on VIDEO_DEV && VIDEO_V4L2 && (PLAT_S5P || ARCH_EXYNOS)
> > drivers/media/platform/Kconfig:177:     depends on VIDEO_DEV && VIDEO_V4L2 && (PLAT_S5P || ARCH_EXYNOS)
> > drivers/media/platform/exynos4-is/Kconfig:5:    depends on (PLAT_S5P || ARCH_EXYNOS)
> > drivers/media/platform/s5p-tv/Kconfig:11:       depends on (PLAT_S5P || ARCH_EXYNOS) && PM_RUNTIME
> > drivers/usb/host/Kconfig:223:       depends on PLAT_S5P || ARCH_EXYNOS
> > drivers/usb/host/Kconfig:530:   depends on PLAT_S5P || ARCH_EXYNOS
> > 
> > Again, I assume patches to remove these references are pending. But is
> > that correct?
> 
> I had two patches fixing those, but apparently this was lost in action.
> The correct solution is s/PLAT_S5P/ARCH_S5PV210/. I will include this in
> a follow-up series if nobody objects.

No one objected, as far as I know.

Exactly the same references are still to be found in v3.17-rc3 and
next-20140903. Perhaps someone actually familiar with this matter (ie,
not me) could submit one or more patches that implement Tomasz'
proposal.


Paul Bolle
