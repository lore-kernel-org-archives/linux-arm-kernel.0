From: leo.yan@linaro.org (Leo Yan)
Date: Mon,  3 Aug 2015 09:13:35 +0800
Subject: [PATCH v3 2/5] dt-bindings: arm: Hi6220: add doc for SRAM controller
In-Reply-To: <1438564418-15948-1-git-send-email-leo.yan@linaro.org>
References: <1438564418-15948-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1438564418-15948-3-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document "hisilicon,hi6220-sramctrl" for SRAM controller.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../devicetree/bindings/arm/hisilicon/hisilicon.txt    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index c431c67..c733e28 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -127,6 +127,24 @@ Example:
 		#clock-cells = <1>;
 	};
 
+
+Hisilicon Hi6220 SRAM controller
+
+Required properties:
+- compatible : "hisilicon,hi6220-sramctrl", "syscon"
+- reg : Register address and size
+
+Hisilicon's SoCs use sram for multiple purpose; on Hi6220 there have several
+SRAM banks for power management, modem, security, etc. Further, use "syscon"
+managing the common sram which can be shared by multiple modules.
+
+Example:
+	/*for Hi6220*/
+	sram: sram at fff80000 {
+		compatible = "hisilicon,hi6220-sramctrl", "syscon";
+		reg = <0x0 0xfff80000 0x0 0x12000>;
+	};
+
 -----------------------------------------------------------------------
 Hisilicon HiP01 system controller
 
-- 
1.9.1
