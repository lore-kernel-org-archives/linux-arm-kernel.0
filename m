From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Wed, 5 Nov 2014 15:35:08 +0530
Subject: [PATCH V2 2/2] ARM: dts: vf-colibri-eval-v3.dts: Enable ST-M41T0M6 RTC
In-Reply-To: <cover.1415181422.git.bhuvanchandra.dv@toradex.com>
References: <cover.1415181422.git.bhuvanchandra.dv@toradex.com>
Message-ID: <b360a079a8a2acfc92a607105fb88bdd731155f7.1415181422.git.bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ST-M41T0M6 is available on Colibri carrier boards.
Hence enable M41T0M6 RTC.

Acked-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index 7324bdc..20251a3 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -35,6 +35,12 @@
 
 &i2c0 {
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
