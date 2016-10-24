From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Mon, 24 Oct 2016 13:20:57 -0300
Subject: [PATCH 37/37] perf coresight: Removing miscellaneous debug output
In-Reply-To: <1477326057-24080-1-git-send-email-acme@kernel.org>
References: <1477326057-24080-1-git-send-email-acme@kernel.org>
Message-ID: <1477326057-24080-38-git-send-email-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Printing the full path of the selected link is obviously not needed,
hence removing.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/1476913323-6836-1-git-send-email-mathieu.poirier at linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
