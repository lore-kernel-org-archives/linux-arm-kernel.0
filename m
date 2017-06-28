From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jun 2017 20:25:36 +0100
Subject: Applied "spi: stm32: replace st, spi-midi with st,
 spi-midi-ns to fit bindings" to the spi tree
In-Reply-To: <1498222550-19092-5-git-send-email-amelie.delaunay@st.com>
Message-ID: <E1dQIam-0004eK-Tq@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: stm32: replace st, spi-midi with st, spi-midi-ns to fit bindings

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 042c1c60df7b85488de28574e7917b7977be3b00 Mon Sep 17 00:00:00 2001
From: Amelie Delaunay <amelie.delaunay@st.com>
Date: Tue, 27 Jun 2017 17:45:16 +0200
Subject: [PATCH] spi: stm32: replace st, spi-midi with st, spi-midi-ns to fit
 bindings

This patch fixes the optional dt property used to set master inter-data
idleness.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 1eb07bef043e..3df4baa68d63 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -582,7 +582,7 @@ static int stm32_spi_prepare_msg(struct spi_master *master,
 
 	/* SPI slave device may need time between data frames */
 	spi->cur_midi = 0;
-	if (np && !of_property_read_u32(np, "st,spi-midi", &spi->cur_midi))
+	if (np && !of_property_read_u32(np, "st,spi-midi-ns", &spi->cur_midi))
 		dev_dbg(spi->dev, "%dns inter-data idleness\n", spi->cur_midi);
 
 	if (spi_dev->mode & SPI_CPOL)
-- 
2.13.2
