From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri,  9 Sep 2016 15:49:06 +0800
Subject: [PATCH 6/6] arm64: dts: rockchip: add pd_usb3 power node for rk3399
In-Reply-To: <1473406836-6720-1-git-send-email-zhangqing@rock-chips.com>
References: <1473406836-6720-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1473407346-7588-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1.add pd node for RK3399 Soc
2.create power domain tree
3.add qos node for domain

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 4b67a249b3bc..1cae76afc8ca 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -703,10 +703,12 @@
 		compatible = "syscon";
 		reg = <0x0 0xffa58000 0x0 0x20>;
 	};
+
 	qos_gmac: qos at ffa5c000 {
 		compatible = "syscon";
 		reg = <0x0 0xffa5c000 0x0 0x20>;
 	};
+
 	qos_pcie: qos at ffa60080 {
 		compatible = "syscon";
 		reg = <0x0 0xffa60080 0x0 0x20>;
@@ -721,6 +723,17 @@
 		compatible = "syscon";
 		reg = <0x0 0xffa60180 0x0 0x20>;
 	};
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
 	qos_sd: qos at ffa74000 {
 		compatible = "syscon";
 		reg = <0x0 0xffa74000 0x0 0x20>;
@@ -900,6 +913,12 @@
 				clocks = <&cru HCLK_SDIO>;
 				pm_qos = <&qos_sdioaudio>;
 			};
+			pd_usb3 at RK3399_PD_USB3 {
+				reg = <RK3399_PD_USB3>;
+				clocks = <&cru ACLK_USB3>;
+				pm_qos = <&qos_usb_otg0>,
+					 <&qos_usb_otg1>;
+			};
 			pd_vio at RK3399_PD_VIO {
 				reg = <RK3399_PD_VIO>;
 				#address-cells = <1>;
-- 
1.9.1
