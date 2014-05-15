From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Thu, 15 May 2014 11:48:54 +0200
Subject: [PATCH 2/3] ARM: dts: kirkwood: enable the PCIe for km_kirkwood
In-Reply-To: <1400147335-20947-1-git-send-email-valentin.longchamp@keymile.com>
References: <1400147335-20947-1-git-send-email-valentin.longchamp@keymile.com>
Message-ID: <1400147335-20947-3-git-send-email-valentin.longchamp@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCIe controller is used on the KM kirkwood reference design.
This enables it.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
---

 arch/arm/boot/dts/kirkwood-km_kirkwood.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
index 61139bf..9f57796 100644
--- a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
+++ b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
@@ -17,6 +17,16 @@
 		stdout-path = &uart0;
 	};
 
+	mbus {
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
+	};
+
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			pinctrl-0 = < &pmx_i2c_gpio_sda &pmx_i2c_gpio_scl >;
-- 
1.8.0.1
