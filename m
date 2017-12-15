From: klaus.goger@theobroma-systems.com (Klaus Goger)
Date: Fri, 15 Dec 2017 13:20:10 +0100
Subject: [PATCH] arm64: rockchip: enable Rockchip IO domain support
Message-ID: <20171215122010.34160-1-klaus.goger@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure the IO domain support is active. This requires to enable
Adaptive Voltage Scaling class support too.

Without Rockchip IO domain support the internal level shifter on the RK3399
will be misconfigured if used in the other voltage domain then the default.

Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>

---

 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 2401373565ff..7c0b0ab12f18 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -150,6 +150,8 @@ config ARCH_ROCKCHIP
 	select GPIOLIB
 	select PINCTRL
 	select PINCTRL_ROCKCHIP
+	select POWER_AVS
+	select ROCKCHIP_IODOMAIN
 	select ROCKCHIP_TIMER
 	help
 	  This enables support for the ARMv8 based Rockchip chipsets,
-- 
2.11.0
