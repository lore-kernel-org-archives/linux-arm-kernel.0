From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Tue, 4 Nov 2014 16:52:10 +0530
Subject: [PATCH 2/2] ARM: dts: vf-colibri-eval-v3.dts: Enable ST-M41T0M6 RTC
In-Reply-To: <cover.1415099486.git.bhuvanchandra.dv@toradex.com>
References: <cover.1415099486.git.bhuvanchandra.dv@toradex.com>
Message-ID: <c7608ccea2f1c791a096fe630a2ac4dd8bb16b60.1415099486.git.bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ST-M41T0M6 is available on Colibri carrier boards.
Hence enable M41T0M6 RTC.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index 0251e6c..f807b5b 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -36,6 +36,12 @@
 &i2c0 {
 	clock-frequency = <400000>;
 	status = "okay";
+
+	/* M41T0M6 real time clock on carrier board */
+	rtc: m41t0m6 at 68 {
+		compatible = "st,m41t00";
+		reg = <0x68>;
+	};
 };
 
 &pwm0 {
-- 
1.7.9.5
