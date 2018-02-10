From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Sat, 10 Feb 2018 02:38:02 +0100
Subject: [PATCH 2/6] ARM: dts: tegra: apalis-tk1: activate pwm pin muxing for
 pwm3
In-Reply-To: <20180210013806.28496-1-marcel@ziswiler.com>
References: <20180210013806.28496-1-marcel@ziswiler.com>
Message-ID: <20180210013806.28496-3-marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Activate PWM pin muxing for Apalis PWM3. Note that the same PWM3 is
already active on pu6 being Apalis BKL1_PWM as well. Therefore exporting
that one for raw sysfs access will fail and one has to revert to using
the pwm backlight.

Downstream commit 668ddb921800 ("apalis-tk1: activate pwm pin muxing for
pwm3").

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index be45b6753916..7fbaaf221029 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -453,12 +453,12 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			/* PWM3 active on pu6 being Apalis BKL1_PWM */
+			/* PWM3 active on pu6 being Apalis BKL1_PWM as well */
 			ph3 {
 				nvidia,pins = "ph3";
-				nvidia,function = "gmi";
-				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,function = "pwm3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 
-- 
2.14.3
