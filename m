From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 12 Feb 2015 18:46:01 +0100
Subject: [PATCH 11/14] ARM: dts: Add ARM System timer as clockevent in armv7m
In-Reply-To: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1423763164-5606-12-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/boot/dts/armv7-m.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/armv7-m.dtsi b/arch/arm/boot/dts/armv7-m.dtsi
index 5a660d0..5b279d3 100644
--- a/arch/arm/boot/dts/armv7-m.dtsi
+++ b/arch/arm/boot/dts/armv7-m.dtsi
@@ -8,6 +8,13 @@
 		reg = <0xe000e100 0xc00>;
 	};
 
+	systick: system-timer {
+		compatible = "arm,armv7m-systick";
+		reg = <0xe000e010 0x10>;
+
+		status = "disabled";
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.9.1
