From: b32955@freescale.com (Huang Shijie)
Date: Mon, 20 May 2013 16:49:02 +0800
Subject: [PATCH 6/6] ARM: dts: imx6qdl: enable the WEIM NOR
In-Reply-To: <1369039742-10893-1-git-send-email-b32955@freescale.com>
References: <1369039742-10893-1-git-send-email-b32955@freescale.com>
Message-ID: <1369039742-10893-7-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the WEIM NOR for imx6q{dl} boards.

For the pin conflict with SPI NOR, its status is set to "disabled".

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index eb293f5..9ce7c1d 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -58,3 +58,24 @@
 	wp-gpios = <&gpio1 13 0>;
 	status = "okay";
 };
+
+&weim {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_weim_nor_1>;
+	#address-cells = <2>;
+	#size-cells = <1>;
+	ranges = <0 0 0x08000000 0x08000000>;
+	status = "disabled"; /* pin conflict with SPI NOR */
+
+	nor at 0,0 {
+		compatible = "cfi-flash";
+		reg = <0 0 0x02000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		bank-width = <2>;
+
+		weim-cs-index = <0>;
+		weim-cs-timing = <0x00620081 0x00000001 0x1C022000
+				0x0000C000 0x1404a38e 0x00000000>;
+	};
+};
-- 
1.7.1
