From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Wed, 17 Sep 2014 13:46:30 +0530
Subject: [PATCH 3/3] ARM: dts: vf610-colibri: Add backlight support
In-Reply-To: <cover.1410930820.git.bhuvanchandra.dv@toradex.com>
References: <cover.1410930820.git.bhuvanchandra.dv@toradex.com>
Message-ID: <cea494421deefe0b862e31b08685074715acf8d6.1410930820.git.bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 arch/arm/boot/dts/vf610-colibri-eval-v3.dts |    6 ++++++
 arch/arm/boot/dts/vf610-colibri.dtsi        |    7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts b/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
index ba98039..f1988a0 100644
--- a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
@@ -52,3 +52,9 @@
 &pwm1 {
 	status = "okay";
 };
+
+&backlight {
+	brightness-levels = <0 4 8 16 32 64 128 255>;
+	default-brightness-level = <6>;
+	status  = "okay";
+};
diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi b/arch/arm/boot/dts/vf610-colibri.dtsi
index 9bd1415..e725306 100644
--- a/arch/arm/boot/dts/vf610-colibri.dtsi
+++ b/arch/arm/boot/dts/vf610-colibri.dtsi
@@ -25,6 +25,13 @@
 		};
 	};
 
+	backlight: bl {
+		compitable = "pwm-backlight";
+		pwms = <&pwm0 0 5000000 0>;
+		pwm-names = " backlight";
+		status = "disabled";
+	};
+
 };
 
 &esdhc1 {
-- 
1.7.9.5
