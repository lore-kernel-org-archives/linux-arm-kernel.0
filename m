From: treding@nvidia.com (Thierry Reding)
Date: Wed, 2 Apr 2014 10:01:08 +0200
Subject: [PATCH] ARM: ux500: Staticise ux500_soc_attr
Message-ID: <1396425668-2571-1-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This variable is not used outside of the file that it's declared in, so
reduce the scope to the local file.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-ux500/cpu.c | 2 +-
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
1.9.1
