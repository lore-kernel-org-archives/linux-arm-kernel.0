From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 29 Mar 2016 23:50:41 +0200
Subject: [PATCH 2/7] ARM: dts: lpc18xx: add rtc node
In-Reply-To: <1459288246-1670-1-git-send-email-manabian@gmail.com>
References: <1459288246-1670-1-git-send-email-manabian@gmail.com>
Message-ID: <1459288246-1670-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for the internal RTC found on all lpc18xx SoCs.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 0b59eae1..e270294 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -215,6 +215,14 @@
 			};
 		};
 
+		rtc: rtc at 40046000 {
+			compatible = "nxp,lpc1850-rtc", "nxp,lpc1788-rtc";
+			reg = <0x40046000 0x1000>;
+			interrupts = <47>;
+			clocks = <&creg_clk 0>, <&ccu1 CLK_CPU_BUS>;
+			clock-names = "rtc", "reg";
+		};
+
 		cgu: clock-controller at 40050000 {
 			compatible = "nxp,lpc1850-cgu";
 			reg = <0x40050000 0x1000>;
-- 
2.7.4
