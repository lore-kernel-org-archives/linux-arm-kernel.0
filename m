From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 30 Oct 2017 23:15:55 +0800
Subject: [PATCH v5 1/3] dt-bindings: hisilicon: add doc for Hi3798CV200
 peripheral controller
In-Reply-To: <1509376557-7187-1-git-send-email-shawnguo@kernel.org>
References: <1509376557-7187-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1509376557-7187-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It adds bindings doc for Hi3798CV200 peripheral controller.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/arm/hisilicon/hisilicon.txt           | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 7111fbc82a4e..199cd36fe1ba 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -75,6 +75,29 @@ Example:
 	};
 
 -----------------------------------------------------------------------
+Hisilicon Hi3798CV200 Peripheral Controller
+
+The Hi3798CV200 Peripheral Controller controls peripherals, queries
+their status, and configures some functions of peripherals.
+
+Required properties:
+- compatible: Should contain "hisilicon,hi3798cv200-perictrl", "syscon"
+  and "simple-mfd".
+- reg: Register address and size of Peripheral Controller.
+- #address-cells: Should be 1.
+- #size-cells: Should be 1.
+
+Examples:
+
+	perictrl: peripheral-controller at 8a20000 {
+		compatible = "hisilicon,hi3798cv200-perictrl", "syscon",
+			     "simple-mfd";
+		reg = <0x8a20000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+-----------------------------------------------------------------------
 Hisilicon Hi6220 system controller
 
 Required properties:
-- 
1.9.1
