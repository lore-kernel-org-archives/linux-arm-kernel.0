From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Sep 2016 09:49:58 +0200
Subject: [PATCH 11/26] ARM: dts: blanche: add support for general purpose LEDs
In-Reply-To: <cover.1473234371.git.horms+renesas@verge.net.au>
References: <cover.1473234371.git.horms+renesas@verge.net.au>
Message-ID: <996453571b33ba2ae07211ff9e8a09b28e49aec5.1473234371.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add support for the general purpose LEDs on the Blanche board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792-blanche.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7792-blanche.dts b/arch/arm/boot/dts/r8a7792-blanche.dts
index 3c6f42b9fe9f..f3ea43b7b724 100644
--- a/arch/arm/boot/dts/r8a7792-blanche.dts
+++ b/arch/arm/boot/dts/r8a7792-blanche.dts
@@ -159,6 +159,23 @@
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		led17 {
+			gpios = <&gpio10 10 GPIO_ACTIVE_HIGH>;
+		};
+		led18 {
+			gpios = <&gpio10 11 GPIO_ACTIVE_HIGH>;
+		};
+		led19 {
+			gpios = <&gpio10 12 GPIO_ACTIVE_HIGH>;
+		};
+		led20 {
+			gpios = <&gpio10 23 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	vcc_sdhi0: regulator-vcc-sdhi0 {
 		compatible = "regulator-fixed";
 
-- 
2.7.0.rc3.207.g0ac5344
