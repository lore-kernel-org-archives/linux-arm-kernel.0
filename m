From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 27 May 2014 17:33:08 +0530
Subject: [PATCH 1/1] ARM: ux500: Staticize ux500_soc_attr
Message-ID: <1401192188-10936-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'ux500_soc_attr' is local to this file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-ux500/cpu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index db16b5a04ad5..4dfa04a96f4d 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -125,7 +125,7 @@ static void __init soc_info_populate(struct soc_device_attribute *soc_dev_attr,
 	soc_dev_attr->revision = ux500_get_revision();
 }
 
-struct device_attribute ux500_soc_attr =
+static struct device_attribute ux500_soc_attr =
 	__ATTR(process,  S_IRUGO, ux500_get_process,  NULL);
 
 struct device * __init ux500_soc_device_init(const char *soc_id)
-- 
1.7.9.5
