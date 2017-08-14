From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Aug 2017 17:42:36 +0100
Subject: Applied "ASoC: rockchip: Delete an error message for a failed memory
 allocation in rockchip_i2s_probe()" to the asoc tree
In-Reply-To: <20170225101834.28232-1-mihai.dumitru2201@stud.acs.upb.ro>
Message-ID: <E1dhIRo-000569-KC@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: Delete an error message for a failed memory allocation in rockchip_i2s_probe()

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

>From b48b2710913d583ff93c365413532e1a7cd60d84 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 10 Aug 2017 18:38:09 +0200
Subject: [PATCH] ASoC: rockchip: Delete an error message for a failed memory
 allocation in rockchip_i2s_probe()

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 199338fdeda0..b6590467fd14 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -579,10 +579,8 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	int val;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
-	if (!i2s) {
-		dev_err(&pdev->dev, "Can't allocate rk_i2s_dev\n");
+	if (!i2s)
 		return -ENOMEM;
-	}
 
 	i2s->dev = &pdev->dev;
 
-- 
2.13.2
