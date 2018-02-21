From: rrajk@nvidia.com (Rajkumar Rampelli)
Date: Wed, 21 Feb 2018 12:28:58 +0530
Subject: [PATCH 09/10] arm64: defconfig: Enable Generic PWM based Tachometer
 driver
In-Reply-To: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
Message-ID: <1519196339-9377-10-git-send-email-rrajk@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Generic PWM based Tachometer driver which implements a simple
interface for monitoring the speed of a fan in roatations per minute,
and exposes it to the user space by using the hwmon's sysfs interface.
Enable this driver as a module in the ARM64 defconfig.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8b2bda7..1b29109 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -321,6 +321,7 @@ CONFIG_BATTERY_BQ27XXX=y
 CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_SENSORS_LM90=m
 CONFIG_SENSORS_INA2XX=m
+CONFIG_GENERIC_PWM_TACHOMETER=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
-- 
2.1.4
