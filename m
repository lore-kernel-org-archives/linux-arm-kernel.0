From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  1 Oct 2015 22:54:38 +0200
Subject: [PATCH 01/16] ARM: dts: lpc18xx: add rgu node
In-Reply-To: <1443732893-17145-1-git-send-email-manabian@gmail.com>
References: <1443732893-17145-1-git-send-email-manabian@gmail.com>
Message-ID: <1443732893-17145-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the NXP LPC1850 RGU (Reset Generation Unit) reset controller
node to the dtsi for all lpc18xx/43xx devices.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 2c569a6ddc9a..29a62b600ae5 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -178,6 +178,14 @@
 				      "base_ssp0_clk",  "base_sdio_clk";
 		};
 
+		rgu: reset-controller at 40053000 {
+			compatible = "nxp,lpc1850-rgu";
+			reg = <0x40053000 0x1000>;
+			clocks = <&cgu BASE_SAFE_CLK>, <&ccu1 CLK_CPU_BUS>;
+			clock-names = "delay", "reg";
+			#reset-cells = <1>;
+		};
+
 		uart0: serial at 40081000 {
 			compatible = "nxp,lpc1850-uart", "ns16550a";
 			reg = <0x40081000 0x1000>;
-- 
1.8.0
