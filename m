From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Thu, 13 Mar 2014 16:38:58 -0300
Subject: [PATCH v2 2/6] ARM: mvebu: Add a 2 GHz fixed-clock on Armada 38x SoCs
In-Reply-To: <1394739542-30017-1-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1394739542-30017-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <1394739542-30017-3-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Armada 38x SoCs have a 2 GHz fixed main PLL that is used to feed
other clocks. This commit adds a DT representation of this clock
through a fixed-clock compatible node.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 812ce28..38fc3a0 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -341,6 +341,13 @@
 	};
 
 	clocks {
+		/* 2 GHz fixed main PLL */
+		mainpll: mainpll {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <2000000000>;
+		};
+
 		/* 25 MHz reference crystal */
 		refclk: oscillator {
 			compatible = "fixed-clock";
-- 
1.9.0
