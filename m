From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 14 Jul 2015 15:39:44 +0200
Subject: [PATCH 09/17] ARM: dts: lpc18xx: add ethernet node
In-Reply-To: <1436881192-23930-1-git-send-email-manabian@gmail.com>
References: <1436881192-23930-1-git-send-email-manabian@gmail.com>
Message-ID: <1436881192-23930-10-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 563435aaee57..be154749bf56 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -78,6 +78,16 @@
 			status = "disabled";
 		};
 
+		mac: ethernet at 40010000 {
+			compatible = "nxp,lpc1850-dwmac", "snps,dwmac-3.611", "snps,dwmac";
+			reg = <0x40010000 0x2000>;
+			interrupts = <5>;
+			interrupt-names	= "macirq";
+			clocks = <&ccu1 CLK_CPU_ETHERNET>;
+			clock-names = "stmmaceth";
+			status = "disabled";
+		};
+
 		creg: syscon at 40043000 {
 			compatible = "nxp,lpc1850-creg", "syscon", "simple-mfd";
 			reg = <0x40043000 0x1000>;
-- 
1.8.0
