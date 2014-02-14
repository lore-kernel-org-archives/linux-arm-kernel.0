From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Feb 2014 17:18:26 -0700
Subject: [PATCH] ARM: tegra: fix RTC0 alias for Cardhu
Message-ID: <1392337106-20584-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This alias entry was evidently cut/paste from a different board, and
not correctly updated to match Cardhu. Fix this.

Fixes: 553c0a200e20 ("ARM: tegra: set up /aliases entries for RTCs")
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This is a fix for v3.14-rc*

 arch/arm/boot/dts/tegra30-cardhu.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 004002c8c8a5..0cf0848a82d8 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -28,7 +28,7 @@
 	compatible = "nvidia,cardhu", "nvidia,tegra30";
 
 	aliases {
-		rtc0 = "/i2c at 7000d000/tps6586x at 34";
+		rtc0 = "/i2c at 7000d000/tps65911 at 2d";
 		rtc1 = "/rtc at 7000e000";
 	};
 
-- 
1.8.1.5
