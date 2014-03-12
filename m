From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 12 Mar 2014 15:19:14 +0900
Subject: [PATCHv2 3/5] ARM: dts: exynos4x12: Add GPS_ALIVE power domain
In-Reply-To: <1394605156-7768-1-git-send-email-cw00.choi@samsung.com>
References: <1394605156-7768-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1394605156-7768-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add GPS_ALIVE power domain for Exynos4x12 SoC. GPS_ALIVE power domain
include GPS_BLK for GPS IP. Exynos SoC used generic power-domain driver to
control power domain. After completed kernel booting, Exynos power-domain driver
disable un-used power domain to reduce power-consumption/leak.

If GPS_ALIVE power domain isn't registered to Exynos power-domain driver,
happen power-leakage because GPS_ALIVE_CONFIGURATION is default power on state.

- 0x10023D00 : GPS_ALIVE_CONFIGURATION register address

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 28b5ec7..0401f4d 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -86,6 +86,11 @@
 		reg = <0x10023CE0 0x20>;
 	};
 
+	pd_gps_alive: gps-alive-power-domain at 10023D00 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023D00 0x20>;
+	};
+
 	gic: interrupt-controller at 10490000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
-- 
1.8.0
