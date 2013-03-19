From: achew@nvidia.com (Andrew Chew)
Date: Tue, 19 Mar 2013 11:59:32 -0700
Subject: [PATCH V4 8/9] ARM: tegra: Provide regulator to pwm-backlight
In-Reply-To: <1363719573-20926-1-git-send-email-achew@nvidia.com>
References: <1363719573-20926-1-git-send-email-achew@nvidia.com>
Message-ID: <1363719573-20926-9-git-send-email-achew@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm-backlight driver now takes a mandatory regulator that is gotten
during driver probe.  Initialize a dummy regulator to satisfy this
requirement.

Signed-off-by: Andrew Chew <achew@nvidia.com>
---
 arch/arm/boot/dts/tegra20-medcom-wide.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-medcom-wide.dts b/arch/arm/boot/dts/tegra20-medcom-wide.dts
index a2d6d65..bf7fdd7 100644
--- a/arch/arm/boot/dts/tegra20-medcom-wide.dts
+++ b/arch/arm/boot/dts/tegra20-medcom-wide.dts
@@ -26,12 +26,18 @@
 		};
 	};
 
+	bl_en: fixed-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "bl-en-supply";
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm 0 5000000>;
 
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
+		enable-supply = <&bl_en>;
 	};
 
 	sound {
-- 
1.8.1.5
