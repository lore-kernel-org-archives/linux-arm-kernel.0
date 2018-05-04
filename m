From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 4 May 2018 09:45:32 +0000
Subject: [PATCH v2 1/2] ARM64: dts: meson-axg: drop sdio pwrseq property
In-Reply-To: <20180504094533.15588-1-yixun.lan@amlogic.com>
References: <20180504094533.15588-1-yixun.lan@amlogic.com>
Message-ID: <20180504094533.15588-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This sdio-pwrseq property is not used untill wifi driver is merged,
also the gpio reset is GPIOX_7 which need to be fixed.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index f67d4e47e641..6b6581c513a8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -48,11 +48,6 @@
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
 	};
-
-	sdio_pwrseq: sdio-pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
-	};
 };
 
 &ethmac {
-- 
2.17.0
