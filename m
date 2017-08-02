From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  2 Aug 2017 10:22:00 -0600
Subject: [PATCH 06/26] hwtracing: coresight: constify attribute_group
 structures.
In-Reply-To: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
References: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1501690940-4137-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
  text	   data	    bss	    dec	    hex	filename
   2573	    288	    296	   3157	    c55	coresight-etm-perf.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   2613	    224	    296	   3133	    c3d	coresight-etm-perf.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 8f546f59a3fd..ad01dfeb2d68 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -60,7 +60,7 @@ static struct attribute *etm_config_formats_attr[] = {
 	NULL,
 };
 
-static struct attribute_group etm_pmu_format_group = {
+static const struct attribute_group etm_pmu_format_group = {
 	.name   = "format",
 	.attrs  = etm_config_formats_attr,
 };
-- 
2.7.4
