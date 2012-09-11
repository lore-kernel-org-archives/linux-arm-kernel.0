From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Sep 2012 11:43:46 -0600
Subject: [PATCH 1/2] ARM: dt: tegra: harmony: configure power off
Message-ID: <1347385427-9676-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Add DT property to tell the TPS6586x that it should provide the
pm_power_off() implementation. This allows "shutdown" to work.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
--
Harmony is a separate patch, since the Harmony regulator support went into
a different branch to other boards' regulator support.
---
 arch/arm/boot/dts/tegra20-harmony.dts |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 0eca40d..b98a1b3 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -281,6 +281,8 @@
 			reg = <0x34>;
 			interrupts = <0 86 0x4>;
 
+			ti,system-power-controller;
+
 			#gpio-cells = <2>;
 			gpio-controller;
 
-- 
1.7.0.4
