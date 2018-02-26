From: broonie@kernel.org (Mark Brown)
Date: Mon, 26 Feb 2018 11:17:31 +0000
Subject: Applied "ASoC: sirf: remove duplicated bit-wise or of
 USP_RXFIFO_THD_INT" to the asoc tree
In-Reply-To: <20180223124117.24686-1-colin.king@canonical.com>
Message-ID: <E1eqGmh-0005VX-8k@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sirf: remove duplicated bit-wise or of USP_RXFIFO_THD_INT

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f49f49aa1541615f1f77bf2c62f184459825ed92 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 23 Feb 2018 12:41:17 +0000
Subject: [PATCH] ASoC: sirf: remove duplicated bit-wise or of
 USP_RXFIFO_THD_INT

Bit pattern USP_RXFIFO_THD_INT is being bit-wise or'd twice;
remove the redundant 2nd USP_RXFIFO_THD_INT

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sirf/sirf-usp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sirf/sirf-usp.h b/sound/soc/sirf/sirf-usp.h
index bf0201cb15bc..e22e13a619e8 100644
--- a/sound/soc/sirf/sirf-usp.h
+++ b/sound/soc/sirf/sirf-usp.h
@@ -154,7 +154,7 @@
 					USP_RX_IO_DMA_INT|\
 					USP_RXFIFO_FULL_INT|\
 					USP_RXFIFO_THD_INT|\
-					USP_RXFIFO_THD_INT|USP_RX_TIMEOUT_INT)
+					USP_RX_TIMEOUT_INT)
 
 #define USP_INT_ALL        0x1FFF
 
-- 
2.16.1
