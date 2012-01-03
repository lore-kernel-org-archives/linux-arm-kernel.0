From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 10:54:25 +0000
Subject: [PATCH 09/12] ARM: EXYNOS: introduce
 arch/arm/mach-exynos/common.[ch]
In-Reply-To: <012601ccca05$57d732b0$07859810$%kim@samsung.com>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
 <1324385316-6052-10-git-send-email-kgene.kim@samsung.com>
 <20111223191935.GS2577@n2100.arm.linux.org.uk>
 <088101ccc1d8$d2023b00$7606b100$%kim@samsung.com>
 <08f401ccc469$9a93a800$cfbaf800$%kim@samsung.com>
 <20120103104120.GK2914@n2100.arm.linux.org.uk>
 <012601ccca05$57d732b0$07859810$%kim@samsung.com>
Message-ID: <20120103105425.GL2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2012 at 07:49:18PM +0900, Kukjin Kim wrote:
> Russell King - ARM Linux wrote:
> > Right, so this is _still_ giving me problems.  7257/1 now applies.  7258/1
> > combines my patch "ARM: restart: exynos4: use new restart hook XXX WIP XXX
> > WHY IS THERE NO LOCAL HEADERS IN arch/arm/mach-exynos4 XXX" with an update
> > from you for the new common.h header, and my "ARM: restart: plat-samsung:
> > remove plat/reset.h and s5p_reset_hook" patch.
> > 
> > This is wrong - s5p_reset_hook is used by other Samsung platforms as well,
> 
> Hmm..I thought the s5p_reset_hook() is not used more on other S5P SoCs,
> because it has been already cleaned up for S5P64X0, S5PC100 and S5PV210.
> Anyway, either way ok to me :)

It's removed by 7252/1 (s5pv210) - what I'm saying is that 'alphabetical'
means that the exynos change should come before 7252/1, and because exynos
removes the s5p_reset_hook (which is shared between s5pv210 and exynos)
things break.

This is exactly why I kept the change separate: it means that the ordering
of the platform specific patches is irrelevant: what matters is that the
ordering of platform specific patches to the common patches.  It means
you don't have to remember that one of the platform specific patches also
touches common code and must be last.

> > and its removal can only happen after _all_ the other platforms have been
> > converted.  If I place your exynos patchs before the other Samsung patches
> > (I'm keeping the platforms in alphabetical order) then things will break.
> > 
> > Please regenerate 7258/1 without my "ARM: restart: plat-samsung:
> > remove plat/reset.h and s5p_reset_hook" patch combined.
> 
> OK, let me do it soon.

Thanks.
