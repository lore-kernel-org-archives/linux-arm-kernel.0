From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 28 Aug 2015 14:42:30 +0200
Subject: [PATCH 3/9] arm: tegra: apalis_t30: fix pin muxing
In-Reply-To: <1440765756-1382-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1440765756-1382-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <1440765756-1382-4-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix pin muxing which got broken due to certain stuff having been
fixed/renamed since.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index fd6c94e..84744dc 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -66,7 +66,7 @@
 			/* BKL1_PWM_EN#, disable TPS65911 PMIC PWM backlight */
 			uart3_cts_n_pa1 {
 				nvidia,pins =	"uart3_cts_n_pa1";
-				nvidia,function = "rsvd1";
+				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
@@ -152,32 +152,32 @@
 			};
 
 			/* Apalis PWM1 */
-			gpio_pu6 {
-				nvidia,pins =	"gpio_pu6";
+			pu6 {
+				nvidia,pins =	"pu6";
 				nvidia,function = "pwm3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* Apalis PWM2 */
-			gpio_pu5 {
-				nvidia,pins =	"gpio_pu5";
+			pu5 {
+				nvidia,pins =	"pu5";
 				nvidia,function = "pwm2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* Apalis PWM3 */
-			gpio_pu4 {
-				nvidia,pins =	"gpio_pu4";
+			pu4 {
+				nvidia,pins =	"pu4";
 				nvidia,function = "pwm1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* Apalis PWM4 */
-			gpio_pu3 {
-				nvidia,pins =	"gpio_pu3";
+			pu3 {
+				nvidia,pins =	"pu3";
 				nvidia,function = "pwm0";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-- 
2.4.3
