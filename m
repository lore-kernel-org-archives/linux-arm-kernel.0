From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 13 Oct 2015 14:28:04 +0300
Subject: [PATCH 3/3] ARM: digicolor: dts: add uart pin configuration
In-Reply-To: <cover.1444735169.git.baruch@tkos.co.il>
References: <cover.1444735169.git.baruch@tkos.co.il>
Message-ID: <2eac21b81251903d99ca97b1e9d4cd5e9ba6839a.1444735169.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/cx92755_equinox.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/cx92755_equinox.dts b/arch/arm/boot/dts/cx92755_equinox.dts
index 5da00806c41e..026f556c8c50 100644
--- a/arch/arm/boot/dts/cx92755_equinox.dts
+++ b/arch/arm/boot/dts/cx92755_equinox.dts
@@ -70,8 +70,17 @@
 
 &uart0 {
 	status = "okay";
+	pinctrl-0 = <&uart0_default>;
+	pinctrl-names = "default";
 };
 
 &i2c {
 	status = "okay";
 };
+
+&pinctrl {
+	uart0_default: uart0_active {
+		pins = "GP_O0", "GP_O1";
+		function = "client_b";
+	};
+};
-- 
2.6.1
