From: stefan@agner.ch (Stefan Agner)
Date: Fri, 18 Jul 2014 19:01:42 +0200
Subject: [PATCH 6/6] ARM: dts: vf610-colibri: add USB support
In-Reply-To: <cover.1405702442.git.stefan@agner.ch>
References: <cover.1405702442.git.stefan@agner.ch>
Message-ID: <438da287f96dfcfd1dbdc4c1255d18d125529850.1405702442.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB support for Colibri VF61 modules. Due to lack of pinmux
options, the USB hosts over-current protection signal of the Colibri
standard could not be connected to the PHY's over-current protection,
hence we need to disable it.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf610-colibri.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-colibri.dts b/arch/arm/boot/dts/vf610-colibri.dts
index aecc7db..f2a950d 100644
--- a/arch/arm/boot/dts/vf610-colibri.dts
+++ b/arch/arm/boot/dts/vf610-colibri.dts
@@ -69,6 +69,16 @@
 	status = "okay";
 };
 
+&usbdev0 {
+	disable-over-current;
+	status = "okay";
+};
+
+&usbh1 {
+	disable-over-current;
+	status = "okay";
+};
+
 &iomuxc {
 	vf610-colibri {
 		pinctrl_esdhc1: esdhc1grp {
-- 
2.0.1
