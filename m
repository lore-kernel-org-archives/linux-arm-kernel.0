From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu, 28 Nov 2013 15:50:39 +0100
Subject: [PATCH v4 4/6] ARM: at91/dt: define sama5d3xek's main clk frequency
In-Reply-To: <1385650171-8756-1-git-send-email-b.brezillon@overkiz.com>
References: <1385650171-8756-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1385650239-8942-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the main clock frequency for the new main clock node
in sama5d3xcm.dtsi.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d3xcm.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
index 726a0f3..dce5419 100644
--- a/arch/arm/boot/dts/sama5d3xcm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
@@ -38,6 +38,12 @@
 			macb0: ethernet at f0028000 {
 				phy-mode = "rgmii";
 			};
+
+			pmc: pmc at fffffc00 {
+				main: mainck {
+					clock-frequency = <12000000>;
+				};
+			};
 		};
 
 		nand0: nand at 60000000 {
-- 
1.7.9.5
