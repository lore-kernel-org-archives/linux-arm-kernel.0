From: nm@ti.com (Nishanth Menon)
Date: Tue, 26 Jun 2018 11:26:14 -0500
Subject: [PATCH V2 4/5] soc: ti: Add Support for AM654 SoC config option
In-Reply-To: <20180626162615.19194-1-nm@ti.com>
References: <20180626162615.19194-1-nm@ti.com>
Message-ID: <20180626162615.19194-5-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add option to build AM6 SoC specific components

Reviewed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Benjamin Fair <b-fair@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1:
 * Picked up Tony's reviewed-by
 
V1:https://patchwork.kernel.org/patch/10475305/
RFC: (new patch broken out from: https://patchwork.kernel.org/patch/10447719/)

 drivers/soc/ti/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index 92770d84a288..be4570baad96 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -1,3 +1,17 @@
+# 64-bit ARM SoCs from TI
+if ARM64
+
+if ARCH_K3
+
+config ARCH_K3_AM6_SOC
+	bool "K3 AM6 SoC"
+	help
+	  Enable support for TI's AM6 SoC Family support
+
+endif
+
+endif
+
 #
 # TI SOC drivers
 #
-- 
2.15.1
