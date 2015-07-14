From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 14 Jul 2015 15:39:43 +0200
Subject: [PATCH 08/17] ARM: dts: lpc18xx: add creg (syscon) node
In-Reply-To: <1436881192-23930-1-git-send-email-manabian@gmail.com>
References: <1436881192-23930-1-git-send-email-manabian@gmail.com>
Message-ID: <1436881192-23930-9-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CREG block contains a collection of miscellaneous
configuration register like Ethernet phy mode, low
power clocks and DMA multiplexer. These registers
needs to be accessed from other drivers and syscon
provides this capability.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 0562f9629b9d..563435aaee57 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -78,6 +78,12 @@
 			status = "disabled";
 		};
 
+		creg: syscon at 40043000 {
+			compatible = "nxp,lpc1850-creg", "syscon", "simple-mfd";
+			reg = <0x40043000 0x1000>;
+			clocks = <&ccu1 CLK_CPU_CREG>;
+		};
+
 		cgu: clock-controller at 40050000 {
 			compatible = "nxp,lpc1850-cgu";
 			reg = <0x40050000 0x1000>;
-- 
1.8.0
