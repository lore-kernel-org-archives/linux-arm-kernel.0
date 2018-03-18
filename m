From: Anson.Huang@nxp.com (Anson Huang)
Date: Sun, 18 Mar 2018 11:14:13 +0800
Subject: [PATCH 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz clock
 source
In-Reply-To: <1521342853-2941-1-git-send-email-Anson.Huang@nxp.com>
References: <1521342853-2941-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1521342853-2941-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX6SX SabreAuto board, there is external 24MHz clock
source for analog clock2, add this clock source to clock tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 72da5ac..83f7cac 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -18,6 +18,14 @@
 		reg = <0x80000000 0x80000000>;
 	};
 
+	clocks {
+		codec_osc: anaclk2 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24576000>;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.7.4
