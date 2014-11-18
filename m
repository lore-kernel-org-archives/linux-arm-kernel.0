From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Tue, 18 Nov 2014 17:38:28 +0530
Subject: [PATCH 1/2] ARM: dts: Fix bootup issue on smdk5250
Message-ID: <1416312509-11530-1-git-send-email-yadi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With default config on smdk5250 latest tree throws below message :

[    2.226049] thermal thermal_zone0: critical temperature reached(224 C),shutting down
[    2.227840] reboot: Failed to start orderly shutdown: forcing the issue

and hangs randomly because it reads wrong temperature value.

I can't figure out any direct relation between LDO10 and TMU from board
schematics which I have. So making LDO10 always-on to fix issue for now.

Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index bc27cc2..95b5b51 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -190,6 +190,7 @@
 				regulator-name = "P1.8V_LDO_OUT10";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
 			};
 
 			ldo11_reg: LDO11 {
-- 
1.7.0.4
