From: stefan@agner.ch (Stefan Agner)
Date: Wed, 10 Feb 2016 16:02:26 -0800
Subject: [PATCH 2/2] ARM: dts: vf-colibri: assign Ethernet clock explicitly
In-Reply-To: <1455148946-26903-1-git-send-email-stefan@agner.ch>
References: <1455148946-26903-1-git-send-email-stefan@agner.ch>
Message-ID: <1455148946-26903-2-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assign Ethernet clock parents explicitly. The Colibri VF61
uses the 50MHz Ethernet clock provided by PLL5.

The Vybrid SoC has two ethernet interfaces (fec0 and fec1) which
use the same clock source (VF610_CLK_ENET). Therefore this parent
configuration affects multiple consumer devices and need to be
specified in the clock provider node.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf-colibri.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index c4312c4..8a889af 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -38,6 +38,13 @@
 	status = "disabled";
 };
 
+&clks {
+	assigned-clocks = <&clks VF610_CLK_ENET_SEL>,
+			  <&clks VF610_CLK_ENET_TS_SEL>;
+	assigned-clock-parents = <&clks VF610_CLK_ENET_50M>,
+				 <&clks VF610_CLK_ENET_50M>;
+};
+
 &dspi1 {
 	bus-num = <1>;
 	pinctrl-names = "default";
-- 
2.7.1
