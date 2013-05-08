From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  8 May 2013 14:29:04 +0100
Subject: [PATCH 4/9] mfd: db8500-prcmu: Supply the pdata_size attribute for
 db8500-thermal
In-Reply-To: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1368019749-19455-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MFD subsystem requires drivers to state the size of any platform
data passed, or it will fail to assign it to the device. This will
culminate in a NULL platform_data attribute and normally a failure to
probe() or a kernel Oops.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/db8500-prcmu.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 319b8ab..5389368 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -3095,6 +3095,7 @@ static struct mfd_cell db8500_prcmu_devs[] = {
 		.num_resources = ARRAY_SIZE(db8500_thsens_resources),
 		.resources = db8500_thsens_resources,
 		.platform_data = &db8500_thsens_data,
+		.pdata_size = sizeof(db8500_thsens_data),
 	},
 };
 
-- 
1.7.10.4
