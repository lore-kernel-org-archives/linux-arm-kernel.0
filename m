From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Jun 2018 16:10:52 +0100 (BST)
Subject: Applied "ASoC: qdsp6: q6asm: remove unused struct q6asm member" to
 the asoc tree
In-Reply-To: <20180626092016.9296-13-srinivas.kandagatla@linaro.org>
Message-ID: <20180626151052.2DE53440070@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: qdsp6: q6asm: remove unused struct q6asm member

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

>From f339155a4063cf3177bb38f6e83760951148e86b Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 26 Jun 2018 10:20:16 +0100
Subject: [PATCH] ASoC: qdsp6: q6asm: remove unused struct q6asm member

pcmdev in struct q6asm seems be left over and unused, so just remove it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index c4fd28f168d5..2b2c7233bb5f 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -174,7 +174,6 @@ struct q6asm {
 	struct device *dev;
 	struct q6core_svc_api_info ainfo;
 	wait_queue_head_t mem_wait;
-	struct platform_device *pcmdev;
 	spinlock_t slock;
 	struct audio_client *session[MAX_SESSIONS + 1];
 };
-- 
2.17.1
