From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 19 Jun 2015 16:46:05 +0800
Subject: [PATCH v2 2/9] ACPICA: ACPI 6.0: Add values for MADT GIC version
 field.
In-Reply-To: <1434703572-26221-1-git-send-email-hanjun.guo@linaro.org>
References: <1434703572-26221-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1434703572-26221-3-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPICA commit 4b100dc43e8baee8c8b4891b23bc7ad03eba6a28

Support for the new version field in the generic distributor
subtable. Hanjun Guo <hanjun.guo@linaro.org>

Link: https://github.com/acpica/acpica/commit/4b100dc4
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---

This patch is also for review purpose only, already merged into
ACPICA core and sent out for review for linux ACPICA by Lv Zheng.
(Thank you, Bob and Lv :) )

 include/acpi/actbl1.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index cadf21c..a21bc50 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -834,6 +834,17 @@ struct acpi_madt_generic_distributor {
 	u8 reserved2[3];	/* reserved - must be zero */
 };
 
+/* Values for Version field above */
+
+enum acpi_madt_gic_version {
+	ACPI_MADT_GIC_VERSION_NONE = 0,
+	ACPI_MADT_GIC_VERSION_V1 = 1,
+	ACPI_MADT_GIC_VERSION_V2 = 2,
+	ACPI_MADT_GIC_VERSION_V3 = 3,
+	ACPI_MADT_GIC_VERSION_V4 = 4,
+	ACPI_MADT_GIC_VERSION_RESERVED = 5	/* 5 and greater are reserved */
+};
+
 /* 13: Generic MSI Frame (ACPI 5.1) */
 
 struct acpi_madt_generic_msi_frame {
-- 
1.9.1
