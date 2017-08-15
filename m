From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Tue, 15 Aug 2017 17:10:09 +0200
Subject: [PATCH 2/5] ASoC: rockchip: constify snd_soc_dai_ops structures
In-Reply-To: <1502809812-13891-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1502809812-13891-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1502809812-13891-3-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These snd_soc_dai_ops structures are only stored in the ops field of
a snd_soc_dai_driver structure, which is const.  Thus, the
snd_soc_dai_ops structures can be const too.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/rockchip/rockchip_pdm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index c5ddeed..400e29e 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -249,7 +249,7 @@ static int rockchip_pdm_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
-static struct snd_soc_dai_ops rockchip_pdm_dai_ops = {
+static const struct snd_soc_dai_ops rockchip_pdm_dai_ops = {
 	.set_fmt = rockchip_pdm_set_fmt,
 	.trigger = rockchip_pdm_trigger,
 	.hw_params = rockchip_pdm_hw_params,
