From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 09:34:14 +0900
Subject: [PATCH 3/7] ARM: shmobile: porter: add I2C2 DT support
In-Reply-To: <cover.1444868963.git.horms+renesas@verge.net.au>
References: <cover.1444868963.git.horms+renesas@verge.net.au>
Message-ID: <d6b940395e430a9afd89131d5de8d7ab1c22f5d1.1444868963.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the Porter board dependent part of the I2C2 device node.

This patch is  analogous to the commit 29a647c396a0 ("ARM: shmobile:
henninger: add I2C2 DT support") as there are no differences between
the boards in this respect.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 7f46980ffd12..03edb8424ef5 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -109,6 +109,11 @@
 		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
 		renesas,function = "sdhi2";
 	};
+
+	i2c2_pins: i2c2 {
+		renesas,groups = "i2c2";
+		renesas,function = "i2c2";
+	};
 };
 
 &scif0 {
@@ -155,6 +160,14 @@
 	status = "okay";
 };
 
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+};
+
 &sata0 {
 	status = "okay";
 };
-- 
2.1.4
