From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jan 2010 22:04:15 +0800
Subject: [PATCH 07/16] [ARM] pxa: remove the unnecessary restoring of MFP
	registers
In-Reply-To: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
References: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1263218664-11546-8-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MFP registers are saved and restored by the mfp sys_device before all
other platform devices, and it is unnecessary here.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 sound/arm/pxa2xx-ac97-lib.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 6fdca97..7587a74 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -345,16 +345,6 @@ EXPORT_SYMBOL_GPL(pxa2xx_ac97_hw_suspend);
 
 int pxa2xx_ac97_hw_resume(void)
 {
-	if (cpu_is_pxa25x() || cpu_is_pxa27x()) {
-		pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
-		pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
-		pxa_gpio_mode(GPIO28_BITCLK_AC97_MD);
-		pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
-	}
-	if (cpu_is_pxa27x()) {
-		/* Use GPIO 113 or 95 as AC97 Reset on Bulverde */
-		set_resetgpio_mode(RESETGPIO_NORMAL_ALTFUNC);
-	}
 	clk_enable(ac97_clk);
 	return 0;
 }
-- 
1.6.3.3
