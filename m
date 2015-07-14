From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 14 Jul 2015 15:39:42 +0200
Subject: [PATCH 07/17] ARM: dts: lpc18xx: add mmcsd node
In-Reply-To: <1436881192-23930-1-git-send-email-manabian@gmail.com>
References: <1436881192-23930-1-git-send-email-manabian@gmail.com>
Message-ID: <1436881192-23930-8-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 813ed93d6570..0562f9629b9d 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -68,6 +68,16 @@
 	};
 
 	soc {
+		mmcsd: mmcsd at 40004000 {
+			compatible = "snps,dw-mshc";
+			reg = <0x40004000 0x1000>;
+			interrupts = <6>;
+			num-slots = <1>;
+			clocks = <&ccu2 CLK_SDIO>, <&ccu1 CLK_CPU_SDIO>;
+			clock-names = "ciu", "biu";
+			status = "disabled";
+		};
+
 		cgu: clock-controller at 40050000 {
 			compatible = "nxp,lpc1850-cgu";
 			reg = <0x40050000 0x1000>;
-- 
1.8.0
