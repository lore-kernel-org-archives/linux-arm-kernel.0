From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 Oct 2018 11:42:18 +0100
Subject: [PATCH] arm64: arch_timer: avoid unused function warning
In-Reply-To: <20181002211214.2672576-1-arnd@arndb.de>
References: <20181002211214.2672576-1-arnd@arndb.de>
Message-ID: <20181003104218.GC12998@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2018 at 11:11:44PM +0200, Arnd Bergmann wrote:
> arm64_1188873_read_cntvct_el0() is protected by the correct
> CONFIG_ARM64_ERRATUM_1188873 #ifdef, but the only reference to it is
> also inside of an CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND section,
> and causes a warning if that is disabled:
> 
> drivers/clocksource/arm_arch_timer.c:323:20: error: 'arm64_1188873_read_cntvct_el0' defined but not used [-Werror=unused-function]
> 
> Since the erratum requires that we always apply the workaround
> in the timer driver, select that symbol as we do for SoC
> specific errata.
> 
> Fixes: 95b861a4a6d9 ("arm64: arch_timer: Add workaround for ARM erratum 1188873")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied. Thanks.

-- 
Catalin
