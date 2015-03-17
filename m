From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 17 Mar 2015 16:33:44 -0600
Subject: [PATCH v16 04/11] ARM: cpuidle: Add cpuidle support for QCOM cpus
In-Reply-To: <1426631631-56937-1-git-send-email-lina.iyer@linaro.org>
References: <1426631631-56937-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1426631631-56937-5-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register cpuidle ops for Krait Processor Sub-System. Supports v1 and v2
versions of KPSS.

Define ARM_QCOM_CPUIDLE config item to enable cpuidle support.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/include/asm/cpuidle_ops.h | 5 +++++
 drivers/cpuidle/Kconfig.arm        | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/include/asm/cpuidle_ops.h b/arch/arm/include/asm/cpuidle_ops.h
index be0a612..adc8874 100644
--- a/arch/arm/include/asm/cpuidle_ops.h
+++ b/arch/arm/include/asm/cpuidle_ops.h
@@ -1,3 +1,8 @@
 /*
  * List of cpuidle operations
  */
+
+#if IS_ENABLED(CONFIG_ARM_QCOM_CPUIDLE)
+CPUIDLE_OPS(qcom_kpss_v1)
+CPUIDLE_OPS(qcom_kpss_v2)
+#endif
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 1ab9a48..b1494acb 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -75,3 +75,10 @@ config ARM_MVEBU_V7_CPUIDLE
 	depends on ARCH_MVEBU
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
