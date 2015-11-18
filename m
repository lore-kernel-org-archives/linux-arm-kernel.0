From: ulrich.hecht+renesas@gmail.com (Ulrich Hecht)
Date: Wed, 18 Nov 2015 13:51:06 +0100
Subject: [PATCH 1/2] ARM: shmobile: alt: add I2C1 DT support
In-Reply-To: <1447851067-8214-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1447851067-8214-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <1447851067-8214-2-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Defines the board-dependent part of the I2C1 device.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index e7c9455..88ed017 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -115,6 +115,11 @@
 		renesas,groups = "eth_link_b", "eth_mdio_b", "eth_rmii_b";
 		renesas,function = "eth";
 	};
+
+	i2c1_pins: i2c1 {
+		renesas,groups = "i2c1";
+		renesas,function = "i2c1";
+	};
 };
 
 &cmt0 {
@@ -134,6 +139,14 @@
 	};
 };
 
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+};
+
 &scif2 {
 	status = "okay";
 };
-- 
2.6.1
