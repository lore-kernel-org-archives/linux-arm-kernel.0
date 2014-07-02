From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  2 Jul 2014 16:28:35 +0100
Subject: [PATCH 03/12] mfd: intel_soc_pmic: Rid compiler working for unused
 ACPI match table
In-Reply-To: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
References: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1404314924-23564-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONIFG_ACPI is not enabled we receive the following warning:

drivers/mfd/intel_soc_pmic_core.c:144:30:
	warning: ?intel_soc_pmic_acpi_match? defined but not used

This patch rids it.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/intel_soc_pmic_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic_core.c
index cddbf5a..2720922 100644
--- a/drivers/mfd/intel_soc_pmic_core.c
+++ b/drivers/mfd/intel_soc_pmic_core.c
@@ -141,11 +141,13 @@ static const struct i2c_device_id intel_soc_pmic_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, intel_soc_pmic_i2c_id);
 
+#if defined(CONFIG_ACPI)
 static struct acpi_device_id intel_soc_pmic_acpi_match[] = {
 	{"INT33FD", (kernel_ulong_t)&intel_soc_pmic_config_crc},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, intel_soc_pmic_acpi_match);
+#endif
 
 static struct i2c_driver intel_soc_pmic_i2c_driver = {
 	.driver = {
-- 
1.8.3.2
