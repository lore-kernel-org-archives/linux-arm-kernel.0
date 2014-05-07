From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 07 May 2014 23:15:03 +0200
Subject: [PATCH v2 08/11] ARM: rockchip: Select ARCH_HAS_RESET_CONTROLLER
In-Reply-To: <3477211.Gkyeur83TV@diego>
References: <3477211.Gkyeur83TV@diego>
Message-ID: <69979379.A4aX5ebo8B@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All known Rockchip SoCs have a reset controller in their CRUs, so it's
helpful to have the reset controller framework selected by default,
only be deselected by the user in special cases.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1caee6d..e4564c2 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -2,6 +2,7 @@ config ARCH_ROCKCHIP
 	bool "Rockchip RK2928 and RK3xxx SOCs" if ARCH_MULTI_V7
 	select PINCTRL
 	select PINCTRL_ROCKCHIP
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
 	select CACHE_L2X0
-- 
1.9.0
