From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 25 Jul 2014 23:49:37 +0200
Subject: [PATCH v3 5/8] ARM: rockchip: enable support for RK3288 SoCs
In-Reply-To: <1406324980-2450-1-git-send-email-heiko@sntech.de>
References: <1406324980-2450-1-git-send-email-heiko@sntech.de>
Message-ID: <1406324980-2450-6-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable HAVE_ARM_ARCH_TIMER and add a rockchip,rk3288 compatible.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/mach-rockchip/Kconfig    | 1 +
 arch/arm/mach-rockchip/rockchip.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index e4564c2..d168669 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -6,6 +6,7 @@ config ARCH_ROCKCHIP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
 	select CACHE_L2X0
+	select HAVE_ARM_ARCH_TIMER
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select DW_APB_TIMER_OF
diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index 968cc34..8ab9e0e 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -29,6 +29,7 @@ static const char * const rockchip_board_dt_compat[] = {
 	"rockchip,rk3066a",
 	"rockchip,rk3066b",
 	"rockchip,rk3188",
+	"rockchip,rk3288",
 	NULL,
 };
 
-- 
1.9.0
