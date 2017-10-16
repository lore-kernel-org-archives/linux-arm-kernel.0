From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 16 Oct 2017 17:46:19 +0530
Subject: [PATCH 1/9] ARM: dts: rockchip: rk3288-vyasa: Remove vdd_log from
 rk808, DCDC_REG1
In-Reply-To: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
References: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1508156187-27519-2-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vdd_log, never used on DCDC_REG1 of rk808 from latest schematic so
remove the same and update the regulator-name as 'vdd_arm' to sync
with existing rk3288 board dts files.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/rk3288-vyasa.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index 3546eb8..7a0f945 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -121,8 +121,8 @@
 		vcc12-supply = <&vcc_io>;
 
 		regulators {
-			vdd_cpu: vdd_log: DCDC_REG1 {
-				regulator-name = "vdd_log";
+			vdd_cpu: DCDC_REG1 {
+				regulator-name = "vdd_arm";
 				regulator-min-microvolt = <750000>;
 				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
-- 
2.7.4
