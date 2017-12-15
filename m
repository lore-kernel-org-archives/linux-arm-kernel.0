From: klaus.goger@theobroma-systems.com (Klaus Goger)
Date: Fri, 15 Dec 2017 18:23:20 +0100
Subject: [PATCH] arm64: defconfig: enable Rockchip IO domain support
Message-ID: <20171215172320.17288-1-klaus.goger@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without Rockchip IO domain support the internal level shifters will
be misconfigured if used with other voltage domains then the default.

Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>

---

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6356c6da34ea..cad81b1723d8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -311,6 +311,8 @@ CONFIG_GPIO_XGENE_SB=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_MAX77620=y
+CONFIG_POWER_AVS=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_POWER_RESET_MSM=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
-- 
2.11.0
