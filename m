From: frank.wang@rock-chips.com (Frank Wang)
Date: Thu, 22 Jun 2017 18:32:40 +0800
Subject: [RESEND PATCH v2 7/7] ARM: dts: rockchip: add efuse device node for
 rk3228
In-Reply-To: <1498127402-6705-1-git-send-email-frank.wang@rock-chips.com>
References: <1498127402-6705-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1498127560-6960-1-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Finley Xiao <finley.xiao@rock-chips.com>

Add a efuse node in the device tree for the rk3228 SoC.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index bd7ef53..70ca103 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -336,6 +336,23 @@
 		status = "disabled";
 	};
 
+	efuse: efuse at 11040000 {
+		compatible = "rockchip,rk3228-efuse";
+		reg = <0x11040000 0x20>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		clocks = <&cru PCLK_EFUSE_256>;
+		clock-names = "pclk_efuse";
+
+		/* Data cells */
+		efuse_id: id at 7 {
+			reg = <0x7 0x10>;
+		};
+		cpu_leakage: cpu_leakage at 17 {
+			reg = <0x17 0x1>;
+		};
+	};
+
 	i2c0: i2c at 11050000 {
 		compatible = "rockchip,rk3228-i2c";
 		reg = <0x11050000 0x1000>;
-- 
2.0.0
