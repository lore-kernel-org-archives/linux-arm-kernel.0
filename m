From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 11 Nov 2015 15:34:31 +0800
Subject: [PATCH 4/4] ARM: dts: rockchip: add eFuse node for rk3188 SoCs
In-Reply-To: <1447227272-1728-1-git-send-email-wxt@rock-chips.com>
References: <1447227272-1728-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1447227272-1728-5-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the eFuse dt node for rk3188 SoCs.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

 arch/arm/boot/dts/rk3188.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 6399942..b01ef45 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -144,6 +144,19 @@
 		#reset-cells = <1>;
 	};
 
+	efuse: efuse at 20010000 {
+		compatible = "rockchip,rockchip-efuse";
+		reg = <0x20010000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		clocks = <&cru PCLK_EFUSE>;
+		clock-names = "pclk_efuse";
+
+		cpu_leakage: cpu_leakage {
+			reg = <0x17 0x1>;
+		};
+	};
+
 	usbphy: phy {
 		compatible = "rockchip,rk3188-usb-phy", "rockchip,rk3288-usb-phy";
 		rockchip,grf = <&grf>;
-- 
1.9.1
