From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Wed, 17 Sep 2014 11:59:13 +0800
Subject: [PATCH v5 4/4] ARM: dts: enable Thermal on rk3288-evb board
In-Reply-To: <1410926353-15674-1-git-send-email-caesar.wang@rock-chips.com>
References: <1410926353-15674-1-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <1410926353-15674-5-git-send-email-caesar.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3288-evb.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 2964370..b68d21b 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -101,6 +101,24 @@
 	status = "okay";
 };
 
+&tsadc {
+        num-trips = <2>;
+
+        trip0-temp = <80>;
+        trip0-type = "passive";
+        trip0-cdev-num = <1>;
+        trip0-cdev-name0 = "thermal-cpufreq-0";
+
+        trip1-temp = <100>;
+        trip1-type = "critical";
+        trip1-cdev-num = <1>;
+        trip1-cdev-name0 = "thermal-cpufreq-0";
+
+        hw-shut-temp = <120>;
+
+        status = "okay";
+};
+
 &pinctrl {
 	buttons {
 		pwrbtn: pwrbtn {
-- 
1.9.1
