From: mrugesh.mk@ti.com (Mrugesh Katepallewar)
Date: Mon, 28 Jan 2013 13:17:48 +0530
Subject: [PATCH V2] ARM: davinci: da850: add RTC DT entries
Message-ID: <1359359268-9781-1-git-send-email-mrugesh.mk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add RTC DT entries in da850 dts file.

Signed-off-by: Mrugesh Katepallewar <mrugesh.mk@ti.com>
---
Applies on top of v3.8-rc4 of linus tree.

This patch is depending on 
"ARM: davinci: da850: add interrupt-parent property in soc node"
https://patchwork.kernel.org/patch/2044101/

Tested on da850-evm device.

Test Procedure:
date 2013.01.28-10:00:00 (usage: date[YYYY.]MM.DD-hh:mm[:ss])
hwclock -w
reset board and check system time.

Changes Since V1:
Remove interrupt-parent property from RTC node.
Change RTC node name in dts and dtsi file.

:100644 100644 37dc5a3... af4b7cc... M	arch/arm/boot/dts/da850-evm.dts
:100644 100644 640ab75... 90be701... M	arch/arm/boot/dts/da850.dtsi
 arch/arm/boot/dts/da850-evm.dts |    3 +++
 arch/arm/boot/dts/da850.dtsi    |    7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 37dc5a3..af4b7cc 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -24,5 +24,8 @@
 		serial2: serial at 1d0d000 {
 			status = "okay";
 		};
+		rtc0: rtc at 1c23000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 640ab75..90be701 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -56,5 +56,12 @@
 			interrupt-parent = <&intc>;
 			status = "disabled";
 		};
+		rtc0: rtc at 1c23000 {
+			compatible = "ti,da830-rtc";
+			reg = <0x23000 0x1000>;
+			interrupts = <19
+				      19>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.9.5
