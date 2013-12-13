From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:30 +0900
Subject: [PATCH 04/69] ARM: shmobile: lager: add MMCIF support on DTS
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <02b4a748c7ef37c2852478e67251a86e36d87152.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager-reference.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager-reference.dts b/arch/arm/boot/dts/r8a7790-lager-reference.dts
index 0a3f0c6..75730f5 100644
--- a/arch/arm/boot/dts/r8a7790-lager-reference.dts
+++ b/arch/arm/boot/dts/r8a7790-lager-reference.dts
@@ -42,6 +42,15 @@
 			gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	fixedregulator3v3: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &pfc {
@@ -57,4 +66,19 @@
 		renesas,groups = "scif1_data";
 		renesas,function = "scif1";
 	};
+
+	mmc1_pins: mmc1 {
+		renesas,groups = "mmc1_data8", "mmc1_ctrl";
+		renesas,function = "mmc1";
+	};
+};
+
+&mmcif1 {
+	pinctrl-0 = <&mmc1_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&fixedregulator3v3>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
 };
-- 
1.8.4
