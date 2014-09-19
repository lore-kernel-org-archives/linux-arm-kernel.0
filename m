From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 19 Sep 2014 20:27:35 +0200
Subject: [PATCH v5 02/11] ACPI / PM: Assign the ->detach() callback when
 attaching the PM domain
In-Reply-To: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1411151264-16245-3-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As as preparation to simplify the detachment of devices from their PM
domains, we assign the ->detach() callback to genpd_dev_pm_detach().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/acpi/device_pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 67075f8..eec5ed5 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1072,6 +1072,8 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 		acpi_dev_pm_full_power(adev);
 		acpi_device_wakeup(adev, ACPI_STATE_S0, false);
 	}
+
+	dev->pm_domain->detach = acpi_dev_pm_detach;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
-- 
1.9.1
