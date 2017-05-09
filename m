From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Tue, 9 May 2017 10:37:05 +0800
Subject: [v3, 1/5] mmc: dt: add compatible into eSDHC required properties
In-Reply-To: <1494297429-12083-1-git-send-email-yangbo.lu@nxp.com>
References: <1494297429-12083-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1494297429-12083-2-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to add compatible into eSDHC required properties.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Added this patch.
Changes for v3:
	- Added possible comaptible list
---
 Documentation/devicetree/bindings/mmc/fsl-esdhc.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
index dedfb02..a2cf5e1 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
@@ -7,6 +7,20 @@ This file documents differences between the core properties described
 by mmc.txt and the properties used by the sdhci-esdhc driver.
 
 Required properties:
+  - compatible : should be "fsl,esdhc", or "fsl,<chip>-esdhc".
+    Possible compatibles for PowerPC:
+	"fsl,mpc8536-esdhc"
+	"fsl,mpc8378-esdhc"
+	"fsl,p2020-esdhc"
+	"fsl,p4080-esdhc"
+	"fsl,t1040-esdhc"
+	"fsl,t4240-esdhc"
+    Possible compatibles for ARM:
+	"fsl,ls1012a-esdhc"
+	"fsl,ls1088a-esdhc"
+	"fsl,ls1043a-esdhc"
+	"fsl,ls1046a-esdhc"
+	"fsl,ls2080a-esdhc"
   - interrupt-parent : interrupt source phandle.
   - clock-frequency : specifies eSDHC base clock frequency.
 
-- 
2.1.0.27.g96db324
