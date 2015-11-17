From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:36 +0800
Subject: [PATCH v3 37/62] arm/acpi: Define a enum for reserved tables
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-38-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

It needs to copy and change the contents of some ACPI and EFI tables for
Dom0. Here define a enum for those tables.

Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/include/asm-arm/acpi.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/xen/include/asm-arm/acpi.h b/xen/include/asm-arm/acpi.h
index 214fc4e..f159d51 100644
--- a/xen/include/asm-arm/acpi.h
+++ b/xen/include/asm-arm/acpi.h
@@ -30,6 +30,18 @@
 
 extern bool_t acpi_disabled;
 
+/* Tables marked as reserved in efi table */
+typedef enum {
+    TBL_FADT,
+    TBL_MADT,
+    TBL_STAO,
+    TBL_XSDT,
+    TBL_RSDP,
+    TBL_EFIT,
+    TBL_MMAP,
+    TBL_MMAX,
+} EFI_MEM_RES;
+
 #ifdef CONFIG_ACPI
 bool_t __init acpi_psci_present(void);
 bool_t __init acpi_psci_hvc_present(void);
-- 
2.1.0
