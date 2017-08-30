From: embed3d@gmail.com (Philipp Rossak)
Date: Wed, 30 Aug 2017 05:01:10 +0200
Subject: [PATCH 7/7] ARM: dts: sun8i: h3: Enable AP6212 BT on uart3 on Nanopi
 M1 Plus
In-Reply-To: <1504062070-13523-1-git-send-email-embed3d@gmail.com>
References: <1504062070-13523-1-git-send-email-embed3d@gmail.com>
Message-ID: <1504062070-13523-8-git-send-email-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Rossak <embed3d@gmail.com>

The BT side of the AP6212 WiFi/BT combo module is connected to
uart3.

Enable BT on this board by enabling uart3 with using additionally
the cts and rts pins.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
index 3054308..8c12419 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
@@ -49,6 +49,7 @@
 	aliases {
 		ethernet0 = &emac;
 		ethernet1 = &ap6212;
+		serial1 = &uart3;
 	};
 
 	reg_gmac_3v3: gmac-3v3 {
@@ -135,3 +136,9 @@
 		function = "gpio_out";
 	};
 };
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>, <&uart3_rts_cts_pins>;
+	status = "okay";
+};
-- 
2.7.4
