From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 27 Sep 2017 09:20:12 +0800
Subject: [PATCH 1/4] ACPICA: Add SMMUv3 device ID mapping index support
In-Reply-To: <1506475215-2731-1-git-send-email-hanjun.guo@linaro.org>
References: <1506475215-2731-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1506475215-2731-2-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SMMUv3 device ID mapping index is used for SMMUv3
MSIs, update the IORT to support that.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 include/acpi/actbl2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 686b6f8..d90277e 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -810,6 +810,7 @@ struct acpi_iort_smmu_v3 {
 	u8 pxm;
 	u8 reserved1;
 	u16 reserved2;
+	u32 id_mapping_index;
 };
 
 /* Values for Model field above */
-- 
1.9.1
