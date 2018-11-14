From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 15 Nov 2018 00:05:54 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: switch CONFIG_PWM_MESON to built-in
Message-ID: <20181114230554.4968-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Meson8b boards (Odroid-C1, EC-100) use a PWM regulator which is the
voltage supply of the CPU cores (this regulator is typically called
"VCCK").
Now that we are preparing support for CPU frequency scaling on Meson8,
Meson8b and Meson8m2 we should build the pwm-meson driver into the
kernel so we can configure the CPU voltage early in the boot process.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 63af6234c1b6..525316285570 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -928,7 +928,7 @@ CONFIG_PWM_ATMEL_TCB=m
 CONFIG_PWM_BCM2835=y
 CONFIG_PWM_BRCMSTB=m
 CONFIG_PWM_FSL_FTM=m
-CONFIG_PWM_MESON=m
+CONFIG_PWM_MESON=y
 CONFIG_PWM_RCAR=m
 CONFIG_PWM_RENESAS_TPU=y
 CONFIG_PWM_ROCKCHIP=m
-- 
2.19.1
