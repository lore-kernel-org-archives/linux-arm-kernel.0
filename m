From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 28 Jul 2014 20:51:22 +0800
Subject: [PATCH v5 7/8] ARM: hisi: set l2 aux for pl310
In-Reply-To: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
References: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1406551883-26154-8-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable L2 aux value for both HI3xxx and HIX5HD2.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-hisi/hisilicon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 7996c6b..284f9a1 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -55,6 +55,8 @@ static const char *hi3xxx_compat[] __initconst = {
 DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
 	.map_io		= hi3620_map_io,
 	.dt_compat	= hi3xxx_compat,
+	.l2c_aux_val	= 0x0,
+	.l2c_aux_mask	= 0xffffffff,
 	.smp		= smp_ops(hi3xxx_smp_ops),
 MACHINE_END
 
@@ -65,5 +67,7 @@ static const char *hix5hd2_compat[] __initconst = {
 
 DT_MACHINE_START(HIX5HD2_DT, "Hisilicon HIX5HD2 (Flattened Device Tree)")
 	.dt_compat	= hix5hd2_compat,
+	.l2c_aux_val	= 0x00050000,
+	.l2c_aux_mask	= 0xfff0ffff,
 	.smp		= smp_ops(hix5hd2_smp_ops),
 MACHINE_END
-- 
1.9.1
