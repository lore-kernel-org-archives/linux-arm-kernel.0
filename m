From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon,  5 Jun 2017 00:01:49 +0800
Subject: [PATCH v2 11/11] [DO NOT MERGE] ARM: sun8i: h3: enable TV output on
 Orange Pi PC
In-Reply-To: <20170604160149.30230-1-icenowy@aosc.io>
References: <20170604160149.30230-1-icenowy@aosc.io>
Message-ID: <20170604160149.30230-12-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Orange Pi PC features a 3.5mm jack with TV output in it.

Enable the TV output.

As it currently do not have jack detection feature, do not merge this
patch.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index 998b60f8d295..a81d25e722e9 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -98,6 +98,10 @@
 	status = "okay";
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -177,6 +181,14 @@
 	status = "okay";
 };
 
+&tcon1 {
+	status = "okay";
+};
+
+&tve0 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.12.2
