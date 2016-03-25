From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 25 Mar 2016 17:30:07 +0800
Subject: [RFC PATCH 1/3] arm64: Append more field of id_aa64mmfr2 for
 cpufeature
In-Reply-To: <1458898209-7486-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1458898209-7486-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1458898209-7486-2-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some new cpu features which can be identified by id_aa64mmfr2,
this patch appends all fields of it.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/include/asm/sysreg.h | 4 ++++
 arch/arm64/kernel/cpufeature.c  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 1a78d6e..c141243 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -142,7 +142,11 @@
 #define ID_AA64MMFR1_HADBS_SHIFT	0
 
 /* id_aa64mmfr2 */
+#define ID_AA64MMFR2_LVA_SHIFT		16
+#define ID_AA64MMFR2_IESB_SHIFT		12
+#define ID_AA64MMFR2_LSM_SHIFT		8
 #define ID_AA64MMFR2_UAO_SHIFT		4
+#define ID_AA64MMFR2_CNP_SHIFT		0
 
 /* id_aa64dfr0 */
 #define ID_AA64DFR0_CTX_CMPS_SHIFT	28
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 943f514..677f17c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -130,7 +130,11 @@ static struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
 };
 
 static struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_LVA_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_IESB_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_LSM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_UAO_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_CNP_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
-- 
1.7.12.4
