From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 08 Mar 2015 22:10:14 +0100
Subject: [PATCH] ASoC: davinci-mcasp: add missing semicolon
Message-ID: <10196569.gafhWQrdaI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent patch introduced a build error because of a trivial typo, this
gets it back to compile.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 6afda7f50754 ("ASoC: davinci-mcasp: Allow complete shutdown of McASP when not in use")
---
I'm guessing this was reported already, but if not, please apply this patch.

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 33cea0728cd2..d40b392b3da2 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1058,7 +1058,7 @@ static int davinci_mcasp_suspend(struct snd_soc_dai *dai)
 	u32 reg;
 	int i;
 
-	context->pm_state = pm_runtime_enabled(mcasp->dev)
+	context->pm_state = pm_runtime_enabled(mcasp->dev);
 	if (!context->pm_state)
 		pm_runtime_get_sync(mcasp->dev);
 
