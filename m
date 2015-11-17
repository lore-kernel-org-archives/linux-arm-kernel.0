From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:37 +0800
Subject: [PATCH v3 38/62] arm/acpi: Add placeholder for efi and acpi load
 address
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-39-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

EFI table, memory description table and some of acpi tables will be
placed after DOM0 memory space. Add placeholder for the starting address
for loading in DOM0 and the size of new added tables. Also add a
placeholder to store the new created tables.

Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/include/asm-arm/domain.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/xen/include/asm-arm/domain.h b/xen/include/asm-arm/domain.h
index 1e61f30..91272e5 100644
--- a/xen/include/asm-arm/domain.h
+++ b/xen/include/asm-arm/domain.h
@@ -125,6 +125,11 @@ struct arch_domain
     } vuart;
 
     unsigned int evtchn_irq;
+#ifdef CONFIG_ACPI
+    void *efi_acpi_table;
+    paddr_t efi_acpi_gpa;
+    paddr_t efi_acpi_len;
+#endif
 }  __cacheline_aligned;
 
 struct arch_vcpu
-- 
2.1.0
