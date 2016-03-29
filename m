From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 29 Mar 2016 23:50:43 +0200
Subject: [PATCH 4/7] ARM: dts: lpc18xx: add dac node
In-Reply-To: <1459288246-1670-1-git-send-email-manabian@gmail.com>
References: <1459288246-1670-1-git-send-email-manabian@gmail.com>
Message-ID: <1459288246-1670-5-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for the 10-bit DAC found on all lpc18xx SoCs.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 88d27ae..fdc991b 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -444,6 +444,15 @@
 			status = "disabled";
 		};
 
+		dac: dac at 400e1000 {
+			compatible = "nxp,lpc1850-dac";
+			reg = <0x400e1000 0x1000>;
+			interrupts = <0>;
+			clocks = <&ccu1 CLK_APB3_DAC>;
+			resets = <&rgu 42>;
+			status = "disabled";
+		};
+
 		can0: can at 400e2000 {
 			compatible = "bosch,c_can";
 			reg = <0x400e2000 0x1000>;
-- 
2.7.4
