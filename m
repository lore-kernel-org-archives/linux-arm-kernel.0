From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 10 Nov 2016 11:18:53 -0700
Subject: [PATCH 7/8] coresight: tmc: Remove duplicate memset
In-Reply-To: <1478801934-26904-1-git-send-email-mathieu.poirier@linaro.org>
References: <1478801934-26904-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1478801934-26904-8-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <Suzuki.Poulose@arm.com>

The tmc_etr_enable_hw() fills the buffer with 0's before enabling
the hardware. So, we don't need an explicit memset() in
tmc_enable_etr_sink_sysfs() before calling the tmc_etr_enable_hw().
This patch removes the explicit memset from tmc_enable_etr_sink_sysfs.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 3b84d0d38c22..5d312699b3b9 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -150,8 +150,6 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 		drvdata->buf = drvdata->vaddr;
 	}
 
-	memset(drvdata->vaddr, 0, drvdata->size);
-
 	drvdata->mode = CS_MODE_SYSFS;
 	tmc_etr_enable_hw(drvdata);
 out:
-- 
2.7.4
