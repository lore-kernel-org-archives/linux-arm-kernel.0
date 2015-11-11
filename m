From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 11 Nov 2015 15:34:30 +0800
Subject: [PATCH 3/4] ARM: dts: rockchip: add eFuse node for rk3066a SoCs
In-Reply-To: <1447227272-1728-1-git-send-email-wxt@rock-chips.com>
References: <1447227272-1728-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1447227272-1728-4-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the eFuse dt node for rk3066a SoCs.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm/boot/dts/rk3066a.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 946f187..f61bb8a 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -153,6 +153,19 @@
 		clock-names = "timer", "pclk";
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
 	timer at 20038000 {
 		compatible = "snps,dw-apb-timer-osc";
 		reg = <0x20038000 0x100>;
-- 
1.9.1
