From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 18 Feb 2011 22:30:30 +0100
Subject: [PATCH 3/5] ARM: mxs: add a dma mask to fec devices
In-Reply-To: <20110218213022.GJ22310@pengutronix.de>
References: <20110218213022.GJ22310@pengutronix.de>
Message-ID: <1298064632-15262-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lothar Wa?mann <LW@KARO-electronics.de>

This is not strictly necessary but the right thing to do.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mxs/devices/platform-fec.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/devices/platform-fec.c b/arch/arm/mach-mxs/devices/platform-fec.c
index c42dff7..9859cf2 100644
--- a/arch/arm/mach-mxs/devices/platform-fec.c
+++ b/arch/arm/mach-mxs/devices/platform-fec.c
@@ -45,6 +45,7 @@ struct platform_device *__init mxs_add_fec(
 		},
 	};
 
-	return mxs_add_platform_device("imx28-fec", data->id,
-			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
+	return mxs_add_platform_device_dmamask("imx28-fec", data->id,
+			res, ARRAY_SIZE(res), pdata, sizeof(*pdata),
+			DMA_BIT_MASK(32));
 }
-- 
1.7.2.3
