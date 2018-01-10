From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Wed, 10 Jan 2018 20:25:12 +0100
Subject: [PATCH v2 12/12] ARM: dts: sun8i: a83t: Enable HDMI on BananaPi M3
In-Reply-To: <20180110192512.19684-1-jernej.skrabec@siol.net>
References: <20180110192512.19684-1-jernej.skrabec@siol.net>
Message-ID: <20180110192512.19684-13-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BananaPi M3 includes HDMI connector, so add support for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 6550bf0e594b..00e47423cd07 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -60,6 +60,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	reg_usb1_vbus: reg-usb1-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb1-vbus";
@@ -82,6 +93,10 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	/* Terminus Tech FE 1.1s 4-port USB 2.0 hub here */
 	status = "okay";
@@ -100,6 +115,16 @@
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &mdio {
 	rgmii_phy: ethernet-phy at 1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.15.1
