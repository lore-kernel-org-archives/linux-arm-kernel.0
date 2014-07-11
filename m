From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Fri, 11 Jul 2014 17:18:27 +0300
Subject: [PATCH 2/8] ARM: tegra: Remove TEGRA124_CLK_EMC from tegra124-car.h
In-Reply-To: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>
References: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1405088313-20048-3-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the TEGRA124_CLK_EMC cell value define for tegra124-car
from the binding headers. This clock has never been able to do
anything and is being replaced with a separate EMC driver with
its own device tree node. Removing the define ensures that any
user will not mistakenly refer to <&tegra_car TEGRA124_CLK_EMC>
instead of <&emc> or similar.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 include/dt-bindings/clock/tegra124-car.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/tegra124-car.h b/include/dt-bindings/clock/tegra124-car.h
index 8a4c589..4faabce 100644
--- a/include/dt-bindings/clock/tegra124-car.h
+++ b/include/dt-bindings/clock/tegra124-car.h
@@ -73,7 +73,7 @@
 #define TEGRA124_CLK_I2C2 54
 #define TEGRA124_CLK_UARTC 55
 #define TEGRA124_CLK_MIPI_CAL 56
-#define TEGRA124_CLK_EMC 57
+/* 57 */
 #define TEGRA124_CLK_USB2 58
 #define TEGRA124_CLK_USB3 59
 /* 60 */
-- 
1.8.1.5
