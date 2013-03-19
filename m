From: achew@nvidia.com (Andrew Chew)
Date: Tue, 19 Mar 2013 11:59:31 -0700
Subject: [PATCH V4 7/9] ARM: vt8500: Provide regulator to pwm-backlight
In-Reply-To: <1363719573-20926-1-git-send-email-achew@nvidia.com>
References: <1363719573-20926-1-git-send-email-achew@nvidia.com>
Message-ID: <1363719573-20926-8-git-send-email-achew@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm-backlight driver now takes a mandatory regulator that is gotten
during driver probe.  Initialize a dummy regulator to satisfy this
requirement.

Signed-off-by: Andrew Chew <achew@nvidia.com>
---
 arch/arm/boot/dts/wm8850-w70v2.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/wm8850-w70v2.dts b/arch/arm/boot/dts/wm8850-w70v2.dts
index fcc660c..47a0b1a 100644
--- a/arch/arm/boot/dts/wm8850-w70v2.dts
+++ b/arch/arm/boot/dts/wm8850-w70v2.dts
@@ -37,11 +37,17 @@
 		};
 	};
 
+	bl_en: fixed-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "bl-en-supply";
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm 0 50000 1>;	/* duty inverted */
 
 		brightness-levels = <0 40 60 80 100 130 190 255>;
 		default-brightness-level = <5>;
+		enable-supply = <&bl_en>;
 	};
 };
-- 
1.8.1.5
