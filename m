From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 24 Apr 2014 17:23:24 -0300
Subject: [PATCH v2 10/10] ARM: mvebu: Enable the thermal sensor in Armada
 380/385 SoC
In-Reply-To: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1398371004-15807-11-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables the thermal sensor found in Armada 380/385 SoCs.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index a064f59..02c6139 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -346,6 +346,12 @@
 				clock-output-names = "nand";
 			};
 
+			thermal at e8078 {
+				compatible = "marvell,armada380-thermal";
+				reg = <0xe4078 0x4>, <0xe404 0x4>;
+				status = "okay";
+			};
+
 			flash at d0000 {
 				compatible = "marvell,armada370-nand";
 				reg = <0xd0000 0x54>;
-- 
1.9.1
