From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:05 +0200
Subject: [PATCH 10/58] arm64: dts: renesas: salvator-xs: enable SATA
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <3a0832d093693ede13f5bbc6a641775aa1f9dfbf.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Add the nodes to enable SATA. Note that MD12 (SW12-7) must be switched
off for that to work.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts  | 14 ++++++++++++++
 arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
index 8c142affee49..ba3357636fdb 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
@@ -151,6 +151,15 @@
 	};
 };
 
+&pca9654 {
+	pcie_sata_switch {
+		gpio-hog;
+		gpios = <7 GPIO_ACTIVE_HIGH>;
+		output-low; /* enable SATA by default */
+		line-name = "PCIE/SATA switch";
+	};
+};
+
 &pfc {
 	usb2_pins: usb2 {
 		groups = "usb2";
@@ -175,6 +184,11 @@
 	};
 };
 
+/* MD12 (SW12-7) must be set 'Off' which is not the default! */
+&sata {
+	status = "okay";
+};
+
 &usb2_phy2 {
 	pinctrl-0 = <&usb2_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
index 9de4e3db1621..45016a06fab1 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
@@ -47,3 +47,17 @@
 &hdmi0_con {
 	remote-endpoint = <&rcar_dw_hdmi0_out>;
 };
+
+&pca9654 {
+	pcie_sata_switch {
+		gpio-hog;
+		gpios = <7 GPIO_ACTIVE_HIGH>;
+		output-low; /* enable SATA by default */
+		line-name = "PCIE/SATA switch";
+	};
+};
+
+/* MD12 (SW12-7) must be set 'Off' which is not the default! */
+&sata {
+	status = "okay";
+};
-- 
2.11.0
