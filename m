From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 19 Oct 2016 15:42:03 -0600
Subject: [PATCH] perf tools: Removing miscellaneous debug output
Message-ID: <1476913323-6836-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Printing the full path of the selected link is obviously not needed,
hence removing.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 47d584da5819..dfea6b635525 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -575,8 +575,6 @@ static FILE *cs_device__open_file(const char *name)
 	snprintf(path, PATH_MAX,
 		 "%s" CS_BUS_DEVICE_PATH "%s", sysfs, name);
 
-	printf("path: %s\n", path);
-
 	if (stat(path, &st) < 0)
 		return NULL;
 
-- 
2.7.4
