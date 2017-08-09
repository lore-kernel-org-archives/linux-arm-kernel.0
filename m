From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 9 Aug 2017 18:53:34 +0800
Subject: [RFC PATCH 1/4] ACPICA: Add SMMUv3 device ID mapping index support
In-Reply-To: <1502276017-63108-1-git-send-email-guohanjun@huawei.com>
References: <1502276017-63108-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1502276017-63108-2-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

SMMUv3 device ID mapping index is used for SMMUv3
MSIs, update the IORT to support that.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 include/acpi/actbl2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index d568948..e9a9842 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -809,6 +809,7 @@ struct acpi_iort_smmu_v3 {
 	u8 pxm;
 	u8 reserved1;
 	u16 reserved2;
+	u32 id_mapping_index;
 };
 
 /* Values for Model field above */
-- 
1.7.12.4
