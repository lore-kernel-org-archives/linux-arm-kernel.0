From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Apr 2012 11:50:34 -0600
Subject: [PATCH 1/2] ARM: dt: tegra trimslice: add RTC I2C device
Message-ID: <1335549035-22286-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

According to the device's datasheet, it can support an interrupt too.
However, the existing board file doesn't specify an interrupt, and I
don't have the schematics, so I can't add an interrupts property. The
current Linux driver doesn't support anyway.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-trimslice.dts |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-trimslice.dts b/arch/arm/boot/dts/tegra-trimslice.dts
index e4fcf9a..23ffa9e 100644
--- a/arch/arm/boot/dts/tegra-trimslice.dts
+++ b/arch/arm/boot/dts/tegra-trimslice.dts
@@ -250,6 +250,11 @@
 
 	i2c at 7000c500 {
 		clock-frequency = <400000>;
+
+		rtc at 56 {
+			compatible = "emmicro,em3027";
+			reg = <0x56>;
+		};
 	};
 
 	i2c at 7000d000 {
-- 
1.7.0.4
