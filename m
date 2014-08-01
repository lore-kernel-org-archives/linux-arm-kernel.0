From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 1 Aug 2014 09:13:27 +0300
Subject: [PATCH v2 3/6] ARM: DTS: da850: Add node for McASP
In-Reply-To: <1406873610-5037-1-git-send-email-peter.ujfalusi@ti.com>
References: <1406873610-5037-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1406873610-5037-4-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Node for mcasp0

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/da850.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 41ce4e8bf227..0bd98cd00816 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -276,6 +276,19 @@
 			ti,davinci-gpio-unbanked = <0>;
 			status = "disabled";
 		};
+
+		mcasp0: mcasp at 01d00000 {
+			compatible = "ti,da830-mcasp-audio";
+			reg = <0x100000 0x2000>,
+			      <0x102000 0x400000>;
+			reg-names = "mpu", "dat";
+			interrupts = <54>;
+			interrupt-names = "common";
+			status = "disabled";
+			dmas = <&edma0 1>,
+				<&edma0 0>;
+			dma-names = "tx", "rx";
+		};
 	};
 	nand_cs3 at 62000000 {
 		compatible = "ti,davinci-nand";
-- 
2.0.2
