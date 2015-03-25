From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 25 Mar 2015 14:25:29 -0600
Subject: [PATCH v18 04/11] ARM: cpuidle: Add cpuidle support for QCOM cpus
In-Reply-To: <1427315136-44321-1-git-send-email-lina.iyer@linaro.org>
References: <1427315136-44321-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1427315136-44321-5-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define ARM_QCOM_CPUIDLE config item to enable cpuidle support.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/cpuidle/Kconfig.arm | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 21340e0..325be7f 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -74,3 +74,10 @@ config ARM_MVEBU_V7_CPUIDLE
 	depends on ARCH_MVEBU && !ARM64
 	help
 	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
+
+config ARM_QCOM_CPUIDLE
+	bool "CPU Idle Driver for QCOM processors"
+	depends on ARCH_QCOM
+	select ARM_CPUIDLE
+	help
+	  Select this to enable cpuidle on QCOM processors.
-- 
2.1.0
