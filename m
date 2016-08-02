From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 18:33:27 +0800
Subject: [PATCH 0002/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802103327.13880-1-baolex.ni@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 arch/arm/common/dmabounce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 1143c4d..22d7a9a 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -98,7 +98,7 @@ static ssize_t dmabounce_show(struct device *dev, struct device_attribute *attr,
 		device_info->bounce_count);
 }
 
-static DEVICE_ATTR(dmabounce_stats, 0400, dmabounce_show, NULL);
+static DEVICE_ATTR(dmabounce_stats, S_IRUSR, dmabounce_show, NULL);
 #endif
 
 
-- 
2.9.2
