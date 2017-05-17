From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 18 May 2017 00:43:54 +0800
Subject: [RFC PATCH 11/11] [DO NOT MERGE] ARM: sun8i: h3: enable TV output on
 Orange Pi PC
In-Reply-To: <20170517164354.16399-1-icenowy@aosc.io>
References: <20170517164354.16399-1-icenowy@aosc.io>
Message-ID: <20170517164354.16399-12-icenowy@aosc.io>
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
index 1a044b17d6c6..9c50ac3e82f3 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -97,6 +97,10 @@
 	status = "okay";
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -169,6 +173,14 @@
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
