From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Jun 2012 16:25:06 +0100
Subject: [PATCH 13/14] ARM: ux500: Enable the AB8500 RTC for all DT:ed DB8500
 based devices
In-Reply-To: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1339428307-3850-14-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we add a node for the AB8500 Real Time Clock in all devices
supporting the DB8500. The AB8500 RTC driver makes use of named
interrupts we provide support for this too.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 55a36ae..26f895f 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -315,6 +315,13 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 
+				ab8500-rtc {
+					compatible = "stericsson,ab8500-rtc";
+					interrupts = <17 0x4
+					              18 0x4>;
+					interrupt-names = "60S", "ALARM";
+				};
+
 				ab8500-gpadc {
 					compatible = "stericsson,ab8500-gpadc";
 					interrupts = <32 0x4
-- 
1.7.9.5
