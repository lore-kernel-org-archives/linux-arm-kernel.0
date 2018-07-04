From: broonie@kernel.org (Mark Brown)
Date: Wed, 04 Jul 2018 15:41:57 +0100
Subject: Applied "ASoC: qdsp6: q6routing: add slim rx routings" to the asoc
 tree
In-Reply-To: <20180704094944.16440-4-srinivas.kandagatla@linaro.org>
Message-ID: <E1faiyj-0003xf-9K@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: qdsp6: q6routing: add slim rx routings

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

>From 9191ffe2d212f64aa2ec311f4294ba7066d1f8a1 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 4 Jul 2018 10:49:41 +0100
Subject: [PATCH] ASoC: qdsp6: q6routing: add slim rx routings

This patch add routings mixer controls for slim rx ports.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index c80fdbc2442e..35269b492761 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -68,6 +68,13 @@
 	{ mix_name, "SEC_MI2S_TX", "SEC_MI2S_TX" },	\
 	{ mix_name, "QUAT_MI2S_TX", "QUAT_MI2S_TX" },	\
 	{ mix_name, "TERT_MI2S_TX", "TERT_MI2S_TX" },		\
+	{ mix_name, "SLIMBUS_0_TX", "SLIMBUS_0_TX" },		\
+	{ mix_name, "SLIMBUS_1_TX", "SLIMBUS_1_TX" },		\
+	{ mix_name, "SLIMBUS_2_TX", "SLIMBUS_2_TX" },		\
+	{ mix_name, "SLIMBUS_3_TX", "SLIMBUS_3_TX" },		\
+	{ mix_name, "SLIMBUS_4_TX", "SLIMBUS_4_TX" },		\
+	{ mix_name, "SLIMBUS_5_TX", "SLIMBUS_5_TX" },		\
+	{ mix_name, "SLIMBUS_6_TX", "SLIMBUS_6_TX" },		\
 	{ mix_name, "PRIMARY_TDM_TX_0", "PRIMARY_TDM_TX_0"},	\
 	{ mix_name, "PRIMARY_TDM_TX_1", "PRIMARY_TDM_TX_1"},	\
 	{ mix_name, "PRIMARY_TDM_TX_2", "PRIMARY_TDM_TX_2"},	\
@@ -122,6 +129,27 @@
 	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,		\
 		id, 1, 0, msm_routing_get_audio_mixer,			\
 		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_0_TX", SLIMBUS_0_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_1_TX", SLIMBUS_1_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_2_TX", SLIMBUS_2_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_3_TX", SLIMBUS_3_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_4_TX", SLIMBUS_4_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_5_TX", SLIMBUS_5_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_6_TX", SLIMBUS_6_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
 	SOC_SINGLE_EXT("PRIMARY_TDM_TX_0", PRIMARY_TDM_TX_0,		\
 		id, 1, 0, msm_routing_get_audio_mixer,			\
 		msm_routing_put_audio_mixer),				\
-- 
2.18.0.rc2
