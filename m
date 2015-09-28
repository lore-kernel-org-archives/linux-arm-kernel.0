From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 28 Sep 2015 15:57:24 +0100
Subject: [PATCH] arm-cci500: Don't enable PMU driver by default
Message-ID: <1443452244-14062-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

Disable building CCI-500 PMU driver by default.

Reported-by: Russell King <linux@arm.linux.org.uk>
Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: arm at kernel.org
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 1a82f3a..0ebca8b 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -36,7 +36,6 @@ config ARM_CCI400_PORT_CTRL
 
 config ARM_CCI500_PMU
 	bool "ARM CCI500 PMU support"
-	default y
 	depends on (ARM && CPU_V7) || ARM64
 	depends on PERF_EVENTS
 	select ARM_CCI_PMU
-- 
1.7.9.5
