From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 13:36:11 +0900
Subject: [PATCH 11/18] ARM: qcom: use const and __initconst for smp_operations
In-Reply-To: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440390978-22796-12-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smp_operations structure is not over-written, so add const
qualifier and replace __initdata with __initconst.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-qcom/platsmp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-qcom/platsmp.c b/arch/arm/mach-qcom/platsmp.c
index 5cde63a..11847cd 100644
--- a/arch/arm/mach-qcom/platsmp.c
+++ b/arch/arm/mach-qcom/platsmp.c
@@ -332,7 +332,7 @@ static void __init qcom_smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-static struct smp_operations smp_msm8660_ops __initdata = {
+static const struct smp_operations smp_msm8660_ops __initconst = {
 	.smp_prepare_cpus	= qcom_smp_prepare_cpus,
 	.smp_secondary_init	= qcom_secondary_init,
 	.smp_boot_secondary	= msm8660_boot_secondary,
@@ -342,7 +342,7 @@ static struct smp_operations smp_msm8660_ops __initdata = {
 };
 CPU_METHOD_OF_DECLARE(qcom_smp, "qcom,gcc-msm8660", &smp_msm8660_ops);
 
-static struct smp_operations qcom_smp_kpssv1_ops __initdata = {
+static const struct smp_operations qcom_smp_kpssv1_ops __initconst = {
 	.smp_prepare_cpus	= qcom_smp_prepare_cpus,
 	.smp_secondary_init	= qcom_secondary_init,
 	.smp_boot_secondary	= kpssv1_boot_secondary,
@@ -352,7 +352,7 @@ static struct smp_operations qcom_smp_kpssv1_ops __initdata = {
 };
 CPU_METHOD_OF_DECLARE(qcom_smp_kpssv1, "qcom,kpss-acc-v1", &qcom_smp_kpssv1_ops);
 
-static struct smp_operations qcom_smp_kpssv2_ops __initdata = {
+static const struct smp_operations qcom_smp_kpssv2_ops __initconst = {
 	.smp_prepare_cpus	= qcom_smp_prepare_cpus,
 	.smp_secondary_init	= qcom_secondary_init,
 	.smp_boot_secondary	= kpssv2_boot_secondary,
-- 
1.9.1
