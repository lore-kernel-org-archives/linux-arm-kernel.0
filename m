From: andy.yan@kernel-upstream.org (Andy Yan)
Date: Sat, 12 Mar 2016 20:50:29 +0800
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: enable CONFIG_PWM_ROCKCHIP=y
Message-ID: <1457787029-9168-1-git-send-email-andy.yan@kernel-upstream.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the current rk3066 based boards use pwm modulate vdd_logic
voltage, the board may hang when the system boot and run to a higher
frequency without pwm enabled, so enable it as builtin.

Signed-off-by: Andy Yan <andy.yan@kernel-upstream.org>
---

 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8e8b2ac..94639b1 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -757,7 +757,7 @@ CONFIG_PWM_ATMEL=m
 CONFIG_PWM_ATMEL_TCB=m
 CONFIG_PWM_FSL_FTM=m
 CONFIG_PWM_RENESAS_TPU=y
-CONFIG_PWM_ROCKCHIP=m
+CONFIG_PWM_ROCKCHIP=y
 CONFIG_PWM_SAMSUNG=m
 CONFIG_PWM_SUN4I=y
 CONFIG_PWM_TEGRA=y
-- 
1.9.1
