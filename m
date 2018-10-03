From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 3 Oct 2018 09:22:36 +0100
Subject: [PATCH] arm64: arch_timer: avoid unused function warning
In-Reply-To: <20181002211214.2672576-1-arnd@arndb.de>
References: <20181002211214.2672576-1-arnd@arndb.de>
Message-ID: <2a0968fd-c690-3eec-ba61-28f9fadd3b28@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/18 22:11, Arnd Bergmann wrote:
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

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
