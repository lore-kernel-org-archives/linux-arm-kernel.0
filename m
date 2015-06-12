From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 12 Jun 2015 15:48:06 -0700
Subject: [PATCH] regulator: Add docbook for soft start
Message-ID: <1434149286-11969-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The docbook for these members is missing. Add them.

Warning(include/linux/regulator/machine.h:147): No description
found for parameter 'soft_start'
Warning(include/linux/regulator/driver.h:197): No description
found for parameter 'set_soft_start'

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 include/linux/regulator/driver.h  | 1 +
 include/linux/regulator/machine.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 125264f8be93..4db9fbe4889d 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -112,6 +112,7 @@ struct regulator_linear_range {
  *               to stabilise after being set to a new value, in microseconds.
  *               The function provides the from and to voltage selector, the
  *               function should return the worst case.
+ * @set_soft_start: Enable soft start for the regulator.
  *
  * @set_suspend_voltage: Set the voltage for the regulator when the system
  *                       is suspended.
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 85a3b457de51..b11be1260129 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -88,6 +88,7 @@ struct regulator_state {
  *           applied.
  * @apply_uV: Apply the voltage constraint when initialising.
  * @ramp_disable: Disable ramp delay when initialising or when setting voltage.
+ * @soft_start: Enable soft start so that voltage ramps slowly.
  * @pull_down: Enable pull down when regulator is disabled.
  *
  * @input_uV: Input voltage for regulator when supplied by another regulator.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
