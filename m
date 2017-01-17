From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Jan 2017 18:44:54 +0000
Subject: Applied "ASoC: sun4i-i2s: Increase DMA max burst to 8" to the asoc
 tree
In-Reply-To: <20170117140230.23142-2-mylene.josserand@free-electrons.com>
Message-ID: <E1cTYkY-0008Ku-Kd@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-i2s: Increase DMA max burst to 8

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

>From ebad64d19377957976963f99ce1fcf2f09796357 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
 <mylene.josserand@free-electrons.com>
Date: Tue, 17 Jan 2017 15:02:21 +0100
Subject: [PATCH] ASoC: sun4i-i2s: Increase DMA max burst to 8
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As done previously for sun4i-codec, the DMA maxburst of 4
is not supported by every SoCs so the DMA controller engine
returns "unsupported value".

As a maxburst of 8 is supported by all variants, this patch
increases it to 8.

For more details, see commit from Chen-Yu Tsai:
commit 730e2dd0cbc7 ("ASoC: sun4i-codec: Increase DMA max burst to 8")

Signed-off-by: Myl??ne Josserand <mylene.josserand@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index f24d19526603..4237323ef594 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -694,10 +694,10 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 	}
 	
 	i2s->playback_dma_data.addr = res->start + SUN4I_I2S_FIFO_TX_REG;
-	i2s->playback_dma_data.maxburst = 4;
+	i2s->playback_dma_data.maxburst = 8;
 
 	i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
-	i2s->capture_dma_data.maxburst = 4;
+	i2s->capture_dma_data.maxburst = 8;
 
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
-- 
2.11.0
