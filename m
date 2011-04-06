From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  6 Apr 2011 11:24:24 +0200
Subject: [PATCH 4/5] driver core/platform_device_add_resources: free resource
	before overwriting
In-Reply-To: <20110301153438.GB15633@suse.de>
References: <20110301153438.GB15633@suse.de>
Message-ID: <1302081865-2962-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/base/platform.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 812d8ff..4a73cbc 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -199,6 +199,7 @@ int platform_device_add_resources(struct platform_device *pdev,
 			return -ENOMEM;
 	}
 
+	kfree(pdev->resource);
 	pdev->resource = r;
 	pdev->num_resources = num;
 	return 0;
-- 
1.7.2.3
