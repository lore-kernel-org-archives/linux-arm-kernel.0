From: dianders@chromium.org (Doug Anderson)
Date: Wed, 10 Sep 2014 21:30:15 -0700
Subject: [PATCH] ARM: dts: Switch i2c0 to 400kHz on rk3288-evb-rk808
Message-ID: <1410409815-22200-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should be able to talk to the PMIC at 400kHz.  No need to talk at
the slow 100kHz.

As measured by ftrace (with a bunch of extra patches, since cpufreq
for rk808 hasn't landed yet):
  before this change: cpu0_set_target() => ~500us
  after this change:  cpu0_set_target() => ~300us

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/rk3288-evb-rk808.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288-evb-rk808.dts b/arch/arm/boot/dts/rk3288-evb-rk808.dts
index 36db177..ff522f8 100644
--- a/arch/arm/boot/dts/rk3288-evb-rk808.dts
+++ b/arch/arm/boot/dts/rk3288-evb-rk808.dts
@@ -18,6 +18,7 @@
 };
 
 &i2c0 {
+	clock-frequency = <400000>;
 	status = "okay";
 
 	rk808: pmic at 1b {
-- 
2.1.0.rc2.206.gedb03e5
