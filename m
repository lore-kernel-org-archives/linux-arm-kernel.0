From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 11 Jun 2017 12:03:43 +0200
Subject: [PATCH 3/3] ARM: multi_v7_defconfig: enable the PWM clock driver
In-Reply-To: <20170611100343.25868-1-martin.blumenstingl@googlemail.com>
References: <20170611100343.25868-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170611100343.25868-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the PWM clock driver (using the common clock and PWM
frameworks) which is used on many devices with Amlogic Meson SoCs to
generate the 32.768 kHz clock for the wireless SDIO chip.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index abbe288a5134..a2cd88d7f56e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -835,6 +835,7 @@ CONFIG_STAGING_BOARD=y
 CONFIG_CROS_EC_CHARDEV=m
 CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_COMMON_CLK_MAX77802=m
+CONFIG_COMMON_CLK_PWM=y
 CONFIG_COMMON_CLK_RK808=m
 CONFIG_COMMON_CLK_S2MPS11=m
 CONFIG_APQ_MMCC_8084=y
-- 
2.13.1
