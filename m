From: wxt@rock-chips.com (Caesar Wang)
Date: Mon, 14 Sep 2015 19:06:38 +0800
Subject: [PATCH 3/3] ARM64: dts: rk3368: Add mailbox device nodes
In-Reply-To: <1442228798-15191-1-git-send-email-wxt@rock-chips.com>
References: <1442228798-15191-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1442228798-15191-4-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds mailbox device nodes in dts.

mailbox is used by the Rockchip CPU cores to communicate
requests to MCU processormZ

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index a712bea..9ac5cca 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -484,6 +484,19 @@
 		status = "disabled";
 	};
 
+	mbox: mbox at ff6b0000 {
+		compatible = "rockchip,rk3368-mailbox";
+		reg = <0x0 0xff6b0000 0x0 0x1000>,
+		      <0x0 0xff8cf000 0x0 0x1000>; /* the end 4k of sram */
+		interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_MAILBOX>;
+		clock-names = "pclk_mailbox";
+		#mbox-cells = <1>;
+	};
+
 	pmugrf: syscon at ff738000 {
 		compatible = "rockchip,rk3368-pmugrf", "syscon";
 		reg = <0x0 0xff738000 0x0 0x1000>;
-- 
1.9.1
