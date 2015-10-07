From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  7 Oct 2015 09:26:43 -0600
Subject: [PATCH 6/6] coresight: etm3x: making error message unambiguous
In-Reply-To: <1444231603-26676-1-git-send-email-mathieu.poirier@linaro.org>
References: <1444231603-26676-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1444231603-26676-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By adding the function name at the beginning of the error
message there is no doubt as to where the failing condition
occurred.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 87374b3388ad..d630b7ece735 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -191,7 +191,8 @@ static void etm_set_prog(struct etm_drvdata *drvdata)
 	isb();
 	if (coresight_timeout_etm(drvdata, ETMSR, ETMSR_PROG_BIT, 1)) {
 		dev_err(drvdata->dev,
-			"timeout observed when probing at offset %#x\n", ETMSR);
+			"%s: timeout observed when probing at offset %#x\n",
+			__func__, ETMSR);
 	}
 }
 
@@ -209,7 +210,8 @@ static void etm_clr_prog(struct etm_drvdata *drvdata)
 	isb();
 	if (coresight_timeout_etm(drvdata, ETMSR, ETMSR_PROG_BIT, 0)) {
 		dev_err(drvdata->dev,
-			"timeout observed when probing at offset %#x\n", ETMSR);
+			"%s: timeout observed when probing at offset %#x\n",
+			__func__, ETMSR);
 	}
 }
 
-- 
1.9.1
