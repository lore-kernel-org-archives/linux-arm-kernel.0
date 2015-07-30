From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 31 Jul 2015 00:24:21 +0200
Subject: [PATCH 3/9] ARM: dts: lpc18xx: add pl172 memory-controller node
In-Reply-To: <1438295067-24407-1-git-send-email-manabian@gmail.com>
References: <1438295067-24407-1-git-send-email-manabian@gmail.com>
Message-ID: <1438295067-24407-4-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All devices in the LPC18xx/43xx familiy contain a ARM PL172
MultiPort Memory Controller (MPMC).

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 619d1732a042..2c569a6ddc9a 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -97,6 +97,20 @@
 			status = "disabled";
 		};
 
+		emc: memory-controller at 40005000 {
+			compatible = "arm,pl172", "arm,primecell";
+			reg = <0x40005000 0x1000>;
+			clocks = <&ccu1 CLK_CPU_EMCDIV>, <&ccu1 CLK_CPU_EMC>;
+			clock-names = "mpmcclk", "apb_pclk";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <0 0 0x1c000000 0x1000000
+				  1 0 0x1d000000 0x1000000
+				  2 0 0x1e000000 0x1000000
+				  3 0 0x1f000000 0x1000000>;
+			status = "disabled";
+		};
+
 		lcdc: lcd-controller at 40008000 {
 			compatible = "arm,pl111", "arm,primecell";
 			reg = <0x40008000 0x1000>;
-- 
1.8.0
