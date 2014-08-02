From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Aug 2014 11:41:34 +0100
Subject: [PATCH 1/2] ARM: EXYNOS: Fix build with PM_SLEEP=n part #2
In-Reply-To: <1405349040-5265-2-git-send-email-b.zolnierkie@samsung.com>
References: <1405349040-5265-1-git-send-email-b.zolnierkie@samsung.com>
 <1405349040-5265-2-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20140802104134.GA30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 04:43:59PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Fix building of exynos_defconfig with disabled CONFIG_PM_SLEEP by
> adding checking whether Exynos cpuidle support is enabled before
> accessing exynos_enter_aftr.
> 
> The build error message:
> arch/arm/mach-exynos/built-in.o:(.data+0x74): undefined reference to `exynos_enter_aftr'
> make: *** [vmlinux] Error 1
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

What's happening with this patch?  I'm still seeing failures in my builds
due to the above error from Tuesday's arm-soc.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
