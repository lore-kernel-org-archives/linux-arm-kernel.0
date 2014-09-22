From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Mon, 22 Sep 2014 15:38:12 +0530
Subject: [PATCH v3 2/2] ARM: dts: vf610-colibri: Add backlight support
In-Reply-To: <cover.1411378369.git.bhuvanchandra.dv@toradex.com>
References: <cover.1411378369.git.bhuvanchandra.dv@toradex.com>
Message-ID: <a4346c3f08566b61dc829116e50f34c94e3268e5.1411378369.git.bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 arch/arm/boot/dts/vf610-colibri-eval-v3.dts |    6 ++++++
 arch/arm/boot/dts/vf610-colibri.dtsi        |    5 +++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts b/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
index 00f63d9..711cf82 100644
--- a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
@@ -19,6 +19,12 @@
 	};
 };
 
+&bl {
+	brightness-levels = <0 4 8 16 32 64 128 255>;
+	default-brightness-level = <6>;
+	status  = "okay";
+};
+
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi b/arch/arm/boot/dts/vf610-colibri.dtsi
index 1f73c1c..807953b 100644
--- a/arch/arm/boot/dts/vf610-colibri.dtsi
+++ b/arch/arm/boot/dts/vf610-colibri.dtsi
@@ -25,6 +25,11 @@
 		};
 	};
 
+	bl: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm0 0 5000000 0>;
+		status = "disabled";
+	};
 };
 
 &esdhc1 {
-- 
1.7.9.5
