From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Mon, 21 Dec 2015 17:49:56 +0300
Subject: [PATCH v2 2/3] ACPI: scan add in amba probing
In-Reply-To: <1450709399-7246-1-git-send-email-aleksey.makarov@linaro.org>
References: <1450709399-7246-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1450709399-7246-3-git-send-email-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Graeme Gregory <graeme.gregory@linaro.org>

Add a new ACPI scan handler for AMBA devices.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/acpi/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 78d5f02..20c8cba 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1922,6 +1922,7 @@ int __init acpi_scan_init(void)
 	acpi_memory_hotplug_init();
 	acpi_pnp_init();
 	acpi_int340x_thermal_init();
+	acpi_amba_init();
 
 	acpi_scan_add_handler(&generic_device_handler);
 
-- 
2.6.4
