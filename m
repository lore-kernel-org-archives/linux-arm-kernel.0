From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 28 Jul 2014 21:41:36 +0800
Subject: [PATCH v6 7/8] ARM: hisi: set l2 aux for pl310
In-Reply-To: <1406551883-26154-8-git-send-email-haojian.zhuang@linaro.org>
References: <1406551883-26154-8-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1406554896-9466-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable L2 aux value for Hi3620.

Changelog:
v6:
  * Remove L2 aux value of hix5hd2 since we still need some discussion.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-hisi/hisilicon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 7996c6b..5c295ee 100644
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
 
-- 
1.9.1
