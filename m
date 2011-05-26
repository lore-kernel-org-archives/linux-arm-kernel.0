From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 26 May 2011 13:44:12 +0200
Subject: [PATCH 3/3] sound: atmel_ssc_dai: fix ssc error path
In-Reply-To: <1306410252-31534-1-git-send-email-nicolas.ferre@atmel.com>
References: <1306410252-31534-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <6ad886bb3afb73fc9db55fd2e01bb453cfb3febd.1306409927.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We do not have to free a resource that is not allocated yet.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 sound/soc/atmel/atmel_ssc_dai.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 7fbfa05..a7a7bbc 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -838,10 +838,8 @@ int atmel_ssc_set_audio(int ssc_id)
 	}
 
 	ssc_pdev = platform_device_alloc("atmel-ssc-dai", ssc_id);
-	if (!ssc_pdev) {
-		ssc_free(ssc);
+	if (!ssc_pdev)
 		return -ENOMEM;
-	}
 
 	/* If we can grab the SSC briefly to parent the DAI device off it */
 	ssc = ssc_request(ssc_id);
-- 
1.7.3
