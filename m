From: broonie@kernel.org (Mark Brown)
Date: Wed, 04 Jul 2018 15:42:02 +0100
Subject: Applied "ASoC: qdsp6: q6afe: Add missing slimbus capture ports" to
 the asoc tree
In-Reply-To: <20180704094944.16440-2-srinivas.kandagatla@linaro.org>
Message-ID: <E1faiyo-0003zj-L2@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: qdsp6: q6afe: Add missing slimbus capture ports

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

>From 25090bc3f36cc3c171ec020dcc89c71db6bd0a67 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 4 Jul 2018 10:49:39 +0100
Subject: [PATCH] ASoC: qdsp6: q6afe: Add missing slimbus capture ports

Existing code already has support for SLIMbus TX and RX, only thing
that was missing from TX side was mapping between virtual to actual
DSP port ids.

This patch adds those mappings.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 671743453fbb..000775b4bba8 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -514,6 +514,20 @@ static struct afe_port_map port_maps[AFE_PORT_MAX] = {
 				SLIMBUS_5_RX, 1, 1},
 	[SLIMBUS_6_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_RX,
 				SLIMBUS_6_RX, 1, 1},
+	[SLIMBUS_0_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_TX,
+				SLIMBUS_0_TX, 0, 1},
+	[SLIMBUS_1_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_TX,
+				SLIMBUS_1_TX, 0, 1},
+	[SLIMBUS_2_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_TX,
+				SLIMBUS_2_TX, 0, 1},
+	[SLIMBUS_3_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_3_TX,
+				SLIMBUS_3_TX, 0, 1},
+	[SLIMBUS_4_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_4_TX,
+				SLIMBUS_4_TX, 0, 1},
+	[SLIMBUS_5_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_TX,
+				SLIMBUS_5_TX, 0, 1},
+	[SLIMBUS_6_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_TX,
+				SLIMBUS_6_TX, 0, 1},
 	[PRIMARY_MI2S_RX] = { AFE_PORT_ID_PRIMARY_MI2S_RX,
 				PRIMARY_MI2S_RX, 1, 1},
 	[PRIMARY_MI2S_TX] = { AFE_PORT_ID_PRIMARY_MI2S_TX,
@@ -1372,6 +1386,13 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 	case AFE_PORT_ID_MULTICHAN_HDMI_RX:
 		cfg_type = AFE_PARAM_ID_HDMI_CONFIG;
 		break;
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_3_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_4_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_TX:
 	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_RX:
 	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_RX:
 	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_RX:
-- 
2.18.0.rc2
