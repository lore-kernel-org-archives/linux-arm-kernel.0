From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Jun 2017 22:07:57 +0100
Subject: Applied "ASoC: rockchip: add bindings for spdif controller" to the
 asoc tree
In-Reply-To: <1496995173-63532-2-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <E1dKt2b-0000KH-0Q@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: add bindings for spdif controller

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 55f42d2e28a42b06907c916c3c71ceb6dfb5afc4 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Fri, 9 Jun 2017 15:59:32 +0800
Subject: [PATCH] ASoC: rockchip: add bindings for spdif controller

this patch add compatible for rk3228/rk3328 spdif,

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rockchip-spdif.txt | 2 ++
 sound/soc/rockchip/rockchip_spdif.c                        | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
index 11046429a118..4706b96d450b 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
@@ -9,7 +9,9 @@ Required properties:
 - compatible: should be one of the following:
    - "rockchip,rk3066-spdif"
    - "rockchip,rk3188-spdif"
+   - "rockchip,rk3228-spdif"
    - "rockchip,rk3288-spdif"
+   - "rockchip,rk3328-spdif"
    - "rockchip,rk3366-spdif"
    - "rockchip,rk3368-spdif"
    - "rockchip,rk3399-spdif"
diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index fa8101d1e16f..ee5055d47d13 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -49,8 +49,12 @@ static const struct of_device_id rk_spdif_match[] = {
 	  .data = (void *)RK_SPDIF_RK3066 },
 	{ .compatible = "rockchip,rk3188-spdif",
 	  .data = (void *)RK_SPDIF_RK3188 },
+	{ .compatible = "rockchip,rk3228-spdif",
+	  .data = (void *)RK_SPDIF_RK3366 },
 	{ .compatible = "rockchip,rk3288-spdif",
 	  .data = (void *)RK_SPDIF_RK3288 },
+	{ .compatible = "rockchip,rk3328-spdif",
+	  .data = (void *)RK_SPDIF_RK3366 },
 	{ .compatible = "rockchip,rk3366-spdif",
 	  .data = (void *)RK_SPDIF_RK3366 },
 	{ .compatible = "rockchip,rk3368-spdif",
-- 
2.11.0
