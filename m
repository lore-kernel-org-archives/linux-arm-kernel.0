From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 16 Apr 2014 11:15:20 -0300
Subject: [PATCH 6/6] ARM: mvebu: Enable the thermal sensor in Armada 375 SoC
In-Reply-To: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1397657720-10893-7-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables the thermal sensor found in Armada 375 SoCs.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 3877693f..7467f9d 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -391,6 +391,12 @@
 				status = "disabled";
 			};
 
+			thermal at e8078 {
+				compatible = "marvell,armada375-thermal";
+				reg = <0xe8078 0x4>, <0xe807c 0x8>;
+				status = "okay";
+			};
+
 			coreclk: mvebu-sar at e8204 {
 				compatible = "marvell,armada-375-core-clock";
 				reg = <0xe8204 0x04>;
-- 
1.9.1
