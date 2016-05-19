From: vigneshr@ti.com (Vignesh R)
Date: Thu, 19 May 2016 14:34:01 +0530
Subject: [RFC PATCH 2/2] ARM: dts: am335x-icev2: Add rotary-encoder node
In-Reply-To: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
References: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
Message-ID: <1463648641-6931-3-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM335x ICE board has a rotary-encoder connected to PCA9536 I2C GPIO
expander. Add DT entry for the same.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

depends on patches to Add TI PCA9536 node posted to linux-gpio:
http://www.spinics.net/lists/arm-kernel/msg505194.html

 arch/arm/boot/dts/am335x-icev2.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index 7d8b8fefdf08..672dccbf203d 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -139,6 +139,17 @@
 			default-state = "off";
 		};
 	};
+
+	rotary-in0 {
+		compatible = "rotary-encoder";
+		gpios = <&pca9536 3 GPIO_ACTIVE_HIGH>,
+			<&pca9536 2 GPIO_ACTIVE_HIGH>,
+			<&pca9536 1 GPIO_ACTIVE_HIGH>,
+			<&pca9536 0 GPIO_ACTIVE_HIGH>;
+		linux,axis = <0>; /* ABS_X */
+		rotary-encoder,steps = <10>;
+		rotary-encoder,absolute-encoder;
+	};
 };
 
 &am33xx_pinmux {
-- 
2.8.2
