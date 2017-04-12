From: kever.yang@rock-chips.com (Kever Yang)
Date: Wed, 12 Apr 2017 15:10:41 +0800
Subject: [PATCH 1/4] arm64: dts: rk3399: add missing qos node
Message-ID: <1491981044-24635-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add qos setting reg for some peripheral like sd, usb, pcie.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 45 ++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index f4f3c96..387ae34 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -769,11 +769,6 @@
 		status = "disabled";
 	};
 
-	qos_sd: qos at ffa74000 {
-		compatible = "syscon";
-		reg = <0x0 0xffa74000 0x0 0x20>;
-	};
-
 	qos_emmc: qos at ffa58000 {
 		compatible = "syscon";
 		reg = <0x0 0xffa58000 0x0 0x20>;
@@ -784,6 +779,41 @@
 		reg = <0x0 0xffa5c000 0x0 0x20>;
 	};
 
+	qos_pcie: qos at ffa60080 {
+		compatible = "syscon";
+		reg = <0x0 0xffa60080 0x0 0x20>;
+	};
+
+	qos_usb_host0: qos at ffa60100 {
+		compatible = "syscon";
+		reg = <0x0 0xffa60100 0x0 0x20>;
+	};
+
+	qos_usb_host1: qos at ffa60180 {
+		compatible = "syscon";
+		reg = <0x0 0xffa60180 0x0 0x20>;
+	};
+
+	qos_usb_otg0: qos at ffa70000 {
+		compatible = "syscon";
+		reg = <0x0 0xffa70000 0x0 0x20>;
+	};
+
+	qos_usb_otg1: qos at ffa70080 {
+		compatible = "syscon";
+		reg = <0x0 0xffa70080 0x0 0x20>;
+	};
+
+	qos_sd: qos at ffa74000 {
+		compatible = "syscon";
+		reg = <0x0 0xffa74000 0x0 0x20>;
+	};
+
+	qos_sdioaudio: qos at ffa76000 {
+		compatible = "syscon";
+		reg = <0x0 0xffa76000 0x0 0x20>;
+	};
+
 	qos_hdcp: qos at ffa90000 {
 		compatible = "syscon";
 		reg = <0x0 0xffa90000 0x0 0x20>;
@@ -854,6 +884,11 @@
 		reg = <0x0 0xffad0000 0x0 0x20>;
 	};
 
+	qos_perihp: qos at ffad8080 {
+		compatible = "syscon";
+		reg = <0x0 0xffad8080 0x0 0x20>;
+	};
+
 	qos_gpu: qos at ffae0000 {
 		compatible = "syscon";
 		reg = <0x0 0xffae0000 0x0 0x20>;
-- 
1.9.1
