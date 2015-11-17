From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:04 +0800
Subject: [PATCH v3 05/62] acpi: Don't do traditional BIOS table scan for ARM64
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-6-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

With the addition of ARM64 that does not have a traditional BIOS to
scan, add a #ifdef option for x86 to do the traditional BIOS scanning
for tables.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/drivers/acpi/osl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/xen/drivers/acpi/osl.c b/xen/drivers/acpi/osl.c
index ce15470..db74a90 100644
--- a/xen/drivers/acpi/osl.c
+++ b/xen/drivers/acpi/osl.c
@@ -78,7 +78,9 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	} else {
 		acpi_physical_address pa = 0;
 
+		#ifdef CONFIG_X86
 		acpi_find_root_pointer(&pa);
+		#endif
 		return pa;
 	}
 }
-- 
2.1.0
