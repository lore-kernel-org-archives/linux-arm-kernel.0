From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 14 Aug 2014 23:00:56 +0200
Subject: [PATCH v2 2/4] ARM: rockchip: enable the AMBA bus
In-Reply-To: <3132019.Q6dzkQ3ylK@diego>
References: <3132019.Q6dzkQ3ylK@diego>
Message-ID: <1771927.azkQgDa6x6@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed to access the pl330 dma controllers on Rockchip SoCs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Kever Yang <kever.yang@rock-chips.com>
---
 arch/arm/mach-rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index d168669..ac5803c 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -4,6 +4,7 @@ config ARCH_ROCKCHIP
 	select PINCTRL_ROCKCHIP
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
 	select ARM_GIC
 	select CACHE_L2X0
 	select HAVE_ARM_ARCH_TIMER
-- 
1.9.0
