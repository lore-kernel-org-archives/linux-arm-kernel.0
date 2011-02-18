From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 18 Feb 2011 22:30:31 +0100
Subject: [PATCH 4/5] ARM: mxc: add a dma mask to fec devices
In-Reply-To: <20110218213022.GJ22310@pengutronix.de>
References: <20110218213022.GJ22310@pengutronix.de>
Message-ID: <1298064632-15262-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is not strictly necessary but the right thing to do.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/devices/platform-fec.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-fec.c b/arch/arm/plat-mxc/devices/platform-fec.c
index 4f52996..6561c9d 100644
--- a/arch/arm/plat-mxc/devices/platform-fec.c
+++ b/arch/arm/plat-mxc/devices/platform-fec.c
@@ -62,7 +62,7 @@ struct platform_device *__init imx_add_fec(
 		},
 	};
 
-	return imx_add_platform_device("fec", 0 /* -1? */,
+	return imx_add_platform_device_dmamask("fec", 0,
 			res, ARRAY_SIZE(res),
-			pdata, sizeof(*pdata));
+			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
 }
-- 
1.7.2.3
