From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed, 30 Aug 2017 17:58:14 +0800
Subject: [PATCH] ASoC: rockchip: constify snd_soc_ops structures
Message-ID: <20170830095814.2030-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add const to dp/dmic snd_soc_ops.

Fixes: 626d84db64d7 (ASoC: rockchip: Add support for DMIC codec)
Fixes: 3313faf1053e (ASoC: rockchip: Add support for DP codec)
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 sound/soc/rockchip/rk3399_gru_sound.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 5ab25962cabd..0513fe480353 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -301,11 +301,11 @@ static const struct snd_soc_ops rockchip_sound_da7219_ops = {
 	.hw_params = rockchip_sound_da7219_hw_params,
 };
 
-static struct snd_soc_ops rockchip_sound_cdndp_ops = {
+static const struct snd_soc_ops rockchip_sound_cdndp_ops = {
 	.hw_params = rockchip_sound_cdndp_hw_params,
 };
 
-static struct snd_soc_ops rockchip_sound_dmic_ops = {
+static const struct snd_soc_ops rockchip_sound_dmic_ops = {
 	.hw_params = rockchip_sound_dmic_hw_params,
 };
 
-- 
2.11.0
