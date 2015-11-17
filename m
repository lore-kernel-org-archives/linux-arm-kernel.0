From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:49 +0800
Subject: [PATCH v3 50/62] xen/efi: store EFI system table in efi structure
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-51-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

When preparing EFI tables for Dom0, it needs the information of EFI
system table. Here store it in efi structure.

Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/common/efi/boot.c | 2 ++
 xen/include/xen/efi.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/xen/common/efi/boot.c b/xen/common/efi/boot.c
index 78d8ae9..6a48624 100644
--- a/xen/common/efi/boot.c
+++ b/xen/common/efi/boot.c
@@ -1155,6 +1155,8 @@ efi_start(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable)
 
     efi_tables();
 
+    efi.est = (long)SystemTable;
+
     /* Collect PCI ROM contents. */
     setup_efi_pci();
 
diff --git a/xen/include/xen/efi.h b/xen/include/xen/efi.h
index e74dad1..e112296 100644
--- a/xen/include/xen/efi.h
+++ b/xen/include/xen/efi.h
@@ -16,6 +16,7 @@ struct efi {
     unsigned long acpi20;       /* ACPI table (ACPI 2.0) */
     unsigned long smbios;       /* SM BIOS table */
     unsigned long smbios3;      /* SMBIOS v3 table */
+    unsigned long est;          /* EFI system table */
 };
 
 extern struct efi efi;
-- 
2.1.0
