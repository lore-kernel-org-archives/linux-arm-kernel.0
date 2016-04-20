From: ddaney.cavm@gmail.com (David Daney)
Date: Tue, 19 Apr 2016 18:40:39 -0700
Subject: [PATCH v5 14/14] arm64, acpi, numa: Default enable ACPI_NUMA with NUMA
In-Reply-To: <1461116439-22991-1-git-send-email-ddaney.cavm@gmail.com>
References: <1461116439-22991-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1461116439-22991-15-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

Signed-off-by: Robert Richter <rrichter@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 5ce9f66..bacf245 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -292,7 +292,7 @@ config ACPI_NUMA
 	bool "NUMA support"
 	depends on NUMA
 	depends on (X86 || IA64 || ARM64)
-	default y if IA64_GENERIC || IA64_SGI_SN2
+	default y if IA64_GENERIC || IA64_SGI_SN2 || ARM64
 
 config ACPI_CUSTOM_DSDT_FILE
 	string "Custom DSDT Table file to include"
-- 
1.7.11.7
