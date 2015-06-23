From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 23 Jun 2015 17:28:53 +0530
Subject: [PATCH 08/17] ARM: dts: dra7: Add dt node for the sycon pcie
In-Reply-To: <1435060743-5511-1-git-send-email-kishon@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
Message-ID: <1435060743-5511-9-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new device tree node for the control module register space where
PCIe registers are present.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 260f300..3f434f7 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -291,6 +291,11 @@
 			reg = <0x4a002e00 0x7c>;
 		};
 
+		dra7_ctrl_pcie: tisyscon at 4a003c00 {
+			compatible = "syscon";
+			reg = <0x4a003c00 0x48>;
+		};
+
 		sdma: dma-controller at 4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
-- 
1.7.9.5
