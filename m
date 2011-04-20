From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 20 Apr 2011 09:44:43 +0200
Subject: [PATCH v2 2/5] driver core/platform_device_add_data: free platform
	data before overwriting
In-Reply-To: <1303285486-28598-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110420074248.GS31131@pengutronix.de>
	<1303285486-28598-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1303285486-28598-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/base/platform.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 65cb4c3..58ad8e8 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -228,6 +228,7 @@ int platform_device_add_data(struct platform_device *pdev, const void *data,
 			return -ENOMEM;
 	}
 
+	kfree(pdev->dev.platform_data);
 	pdev->dev.platform_data = d;
 	return 0;
 }
-- 
1.7.4.1
