From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 28 Aug 2015 14:42:36 +0200
Subject: [PATCH 9/9] arm: tegra: apalis_t30: fix power/wakeup key for eval
 board
In-Reply-To: <1440765756-1382-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1440765756-1382-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <1440765756-1382-10-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than a power key WAKE1_MICO is actually a standard Apalis MXM3
pin used for wake-up purpose which this patch fixes.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index c832c15..f2879cf 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -191,10 +191,10 @@
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
-			label = "Power";
+		wakeup {
+			label = "WAKE1_MICO";
 			gpios = <&gpio TEGRA_GPIO(V, 1) GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_POWER>;
+			linux,code = <KEY_WAKEUP>;
 			debounce-interval = <10>;
 			gpio-key,wakeup;
 		};
-- 
2.4.3
