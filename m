From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Fri,  3 Apr 2015 19:01:18 +0200
Subject: [PATCH v5 12/15] ARM: dts: Add ARM System timer as clockevent in
 armv7m
In-Reply-To: <1428080481-18591-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1428080481-18591-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1428080481-18591-13-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/boot/dts/armv7-m.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armv7-m.dtsi b/arch/arm/boot/dts/armv7-m.dtsi
index 5a660d0..b1ad7cf 100644
--- a/arch/arm/boot/dts/armv7-m.dtsi
+++ b/arch/arm/boot/dts/armv7-m.dtsi
@@ -8,6 +8,12 @@
 		reg = <0xe000e100 0xc00>;
 	};
 
+	systick: timer at e000e010 {
+		compatible = "arm,armv7m-systick";
+		reg = <0xe000e010 0x10>;
+		status = "disabled";
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.9.1
