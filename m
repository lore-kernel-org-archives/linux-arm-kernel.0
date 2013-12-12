From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 12 Dec 2013 14:31:37 +0100
Subject: [PATCH 2/3] ARM: ux500: Configure regulator for I/O voltage for
 SD-card slot
In-Reply-To: <1386855098-14272-1-git-send-email-ulf.hansson@linaro.org>
References: <1386855098-14272-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1386855098-14272-3-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be able to enable SDR12|25 for SD-cards, we needed to fixup the
configuration in DT of the gpio regulator, which handles the signal
voltage level. Some configuration were missing and some were wrong.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: devicetree at vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/boot/dts/ste-hrefprev60.dtsi  |    2 --
 arch/arm/boot/dts/ste-hrefv60plus.dtsi |    5 +++++
 arch/arm/boot/dts/ste-snowball.dts     |    6 ++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/ste-hrefprev60.dtsi b/arch/arm/boot/dts/ste-hrefprev60.dtsi
index af9914e..40f0ecd 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dtsi
+++ b/arch/arm/boot/dts/ste-hrefprev60.dtsi
@@ -68,8 +68,6 @@
 		vmmci: regulator-gpio {
 			gpios = <&tc3589x_gpio 18 0x4>;
 			enable-gpio = <&tc3589x_gpio 17 0x4>;
-
-			status = "okay";
 		};
 
 		pinctrl {
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
index 1f7b46b..3b6d118 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dtsi
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
@@ -22,6 +22,11 @@
 			cd-gpios  = <&gpio2 31 0x4>; // 95
 		};
 
+		vmmci: regulator-gpio {
+			gpios = <&gpio0 5 0x4>;
+			enable-gpio = <&gpio5 9 0x4>;
+		};
+
 		pinctrl {
 			/*
 			 * Set this up using hogs, as time goes by and as seems fit, these
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 9070c37..97d5d21 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -146,10 +146,8 @@
 		};
 
 		vmmci: regulator-gpio {
-			gpios = <&gpio6 25 0x4>;
-			enable-gpio = <&gpio7 4 0x4>;
-
-			status = "okay";
+			gpios = <&gpio7 4 0x4>;
+			enable-gpio = <&gpio6 25 0x4>;
 		};
 
 		// External Micro SD slot
-- 
1.7.9.5
