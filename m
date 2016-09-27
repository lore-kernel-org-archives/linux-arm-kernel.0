From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 27 Sep 2016 14:44:25 +0100
Subject: [PATCH 3/3] coresight: tmc: Remove duplicate memset
In-Reply-To: <1474983865-11816-1-git-send-email-suzuki.poulose@arm.com>
References: <1474983865-11816-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1474983865-11816-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tmc_etr_enable_hw() fills the buffer with 0's before enabling
the hardware. So, we don't need an explicit memset() in
tmc_enable_etr_sink_sysfs() before calling the tmc_etr_enable_hw().
This patch removes the explicit memset from tmc_enable_etr_sink_sysfs.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 3b84d0d..5d31269 100644
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
