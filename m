From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jun 2017 20:25:48 +0100
Subject: Applied "spi: stm32: fix compatible to fit with new bindings" to the
 spi tree
In-Reply-To: <1498222550-19092-3-git-send-email-amelie.delaunay@st.com>
Message-ID: <E1dQIay-0004gJ-DK@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: stm32: fix compatible to fit with new bindings

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

>From c5fe2faabad41737fa36cedc1c6e15cbc9ddff11 Mon Sep 17 00:00:00 2001
From: Amelie Delaunay <amelie.delaunay@st.com>
Date: Tue, 27 Jun 2017 17:45:14 +0200
Subject: [PATCH] spi: stm32: fix compatible to fit with new bindings

This patch updates of_device_id compatible string to fit with new
bindings.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 305ecd5334fc..1eb07bef043e 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1038,7 +1038,7 @@ static int stm32_spi_config(struct stm32_spi *spi)
 }
 
 static const struct of_device_id stm32_spi_of_match[] = {
-	{ .compatible = "st,stm32-spi", },
+	{ .compatible = "st,stm32h7-spi", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_spi_of_match);
-- 
2.13.2
