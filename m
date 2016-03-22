From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Tue, 22 Mar 2016 13:46:29 +0300
Subject: [PATCH v5 2/6] ACPI: add definitions of DBG2 subtypes
In-Reply-To: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
References: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1458643595-14719-3-git-send-email-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent version of Microsoft Debug Port Table 2 (DBG2) [1]
specifies additional serial debug port subtypes.  These constants
are also referred by Serial Port Console Redirection Table (SPCR) [2]

Add these constants.

[1] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639131(v=vs.85).aspx
[2] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639132(v=vs.85).aspx

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 include/acpi/actbl2.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index a4ef625..652f747 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -371,6 +371,11 @@ struct acpi_dbg2_device {
 
 #define ACPI_DBG2_16550_COMPATIBLE  0x0000
 #define ACPI_DBG2_16550_SUBSET      0x0001
+#define ACPI_DBG2_ARM_PL011         0x0003
+#define ACPI_DBG2_ARM_SBSA_32BIT    0x000D
+#define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
+#define ACPI_DBG2_ARM_DCC           0x000F
+#define ACPI_DBG2_BCM2835           0x0010
 
 #define ACPI_DBG2_1394_STANDARD     0x0000
 
-- 
2.7.4
