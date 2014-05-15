From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 15 May 2014 20:34:24 +0530
Subject: [PATCH v5 4/4] ARM: dts: enable hdmi for exynos5800 based peach-pi
 board
In-Reply-To: <1400166264-3428-1-git-send-email-rahul.sharma@samsung.com>
References: <1400166264-3428-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1400166264-3428-5-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Enable hdmi for peach-pi board.

Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5800-peach-pi.dts |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 742655b..5a44871 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -72,6 +72,13 @@
 		samsung,pin-pud = <0>;
 		samsung,pin-drv = <0>;
 	};
+
+	hdmi_hpd_irq: hdmi-hpd-irq {
+		samsung,pins = "gpx3-7";
+		samsung,pin-function = <0>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <0>;
+	};
 };
 
 &rtc {
@@ -134,6 +141,21 @@
 	};
 };
 
+&i2c_2 {
+	status = "okay";
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-max-bus-freq = <66000>;
+	samsung,i2c-slave-addr = <0x50>;
+};
+
+&hdmi {
+	status = "okay";
+	hpd-gpio = <&gpx3 7 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_hpd_irq>;
+	ddc = <&i2c_2>;
+};
+
 /*
  * Use longest HW watchdog in SoC (32 seconds) since the hardware
  * watchdog provides no debugging information (compared to soft/hard
-- 
1.7.9.5
