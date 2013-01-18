From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Jan 2013 22:30:36 +0100
Subject: [PATCH 4/7] ARM: sunxi: Add pinctrl node to the device tree
In-Reply-To: <1358544639-14761-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1358544639-14761-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1358544639-14761-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 59a2d26..707bef5 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -17,4 +17,13 @@
 	memory {
 		reg = <0x40000000 0x20000000>;
 	};
+
+	soc {
+		pinctrl at 01c20800 {
+			compatible = "allwinner,sun5i-a13-pinctrl";
+			reg = <0x01c20800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
 };
-- 
1.7.10.4
