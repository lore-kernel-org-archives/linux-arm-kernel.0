From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 23 Mar 2017 11:53:40 -0400
Subject: [PATCH] ACPI / IPMI: allow ACPI_IPMI with IPMI_SSIF
Message-ID: <1490284420-26657-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI_IPMI driver currently depends on IPMI System Interface (IPMI_SI) driver
to be enabled. IPMI_SI driver only handles KCS, SMIC and BT BMC interfaces.

IPMI_SSIF is an alternative BMC communication method. It allows BMC to be
accessed over an I2C bus instead of a standard interface.

Enabling ACPI_IPMI over IPMI_SSIF with this change.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 83e5f7e..8767062 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -256,7 +256,7 @@ config ACPI_PROCESSOR
 
 config ACPI_IPMI
 	tristate "IPMI"
-	depends on IPMI_SI
+	depends on IPMI_SI||IPMI_SSIF
 	default n
 	help
 	  This driver enables the ACPI to access the BMC controller. And it
-- 
1.9.1
