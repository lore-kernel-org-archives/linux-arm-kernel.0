From: codekipper@gmail.com (codekipper at gmail.com)
Date: Mon, 21 Mar 2016 17:10:42 +0100
Subject: [linux-sunxi][PATCH v2 5/5] ARM: dts: sun7i: Add SPDIF to Itead Ibox
In-Reply-To: <1458576642-4078-1-git-send-email-codekipper@gmail.com>
References: <1458576642-4078-1-git-send-email-codekipper@gmail.com>
Message-ID: <1458576642-4078-6-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Enable the S/PDIF transmitter that is present on the Itead Ibox.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
index a512581..df76b74 100644
--- a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
@@ -65,6 +65,23 @@
 			default-state = "on";
 		};
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "On-board SPDIF";
+		simple-audio-card,cpu {
+			sound-dai = <&spdif>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&spdif_out>;
+		};
+	};
+
+	spdif_out: spdif-out {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+	};
 };
 
 &ahci {
@@ -131,6 +148,13 @@
 	status = "okay";
 };
 
+
+&spdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spdif_tx_pins_a>;
+	status = "okay";
+};
+
 &usbphy {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb0_id_detect_pin>;
-- 
2.7.4
