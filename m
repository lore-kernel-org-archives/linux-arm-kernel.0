From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 15 Oct 2013 12:56:02 +0200
Subject: [PATCH 1/2] ARM: rockchip: fix wrong use of non-existent
 CONFIG_LOCAL_TIMERS
In-Reply-To: <201310151254.46554.heiko.stuebner@bqreaders.com>
References: <201310151254.46554.heiko.stuebner@bqreaders.com>
Message-ID: <201310151256.02551.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_LOCAL_TIMERS was removed in february, so the twd never gets
selected. Fix this by making the twd depend on SMP directly.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-rockchip/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 25ee12b..a848733 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -5,9 +5,8 @@ config ARCH_ROCKCHIP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
 	select CACHE_L2X0
-	select HAVE_ARM_TWD if LOCAL_TIMERS
+	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
-	select LOCAL_TIMERS if SMP
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
 	select DW_APB_TIMER_OF
-- 
1.7.10.4
