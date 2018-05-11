From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 May 2018 03:36:52 +0100 (BST)
Subject: Applied "ARM: ep93xx: i2s: Add IRQ to platform device resources" to
 the asoc tree
In-Reply-To: <20180428205142.31921-5-alexander.sverdlin@gmail.com>
Message-ID: <20180511023652.3546E44007A@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ARM: ep93xx: i2s: Add IRQ to platform device resources

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

>From 6ea8a84806ac91809e1759a200bf3c272b12aeb9 Mon Sep 17 00:00:00 2001
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Date: Sat, 28 Apr 2018 22:51:41 +0200
Subject: [PATCH] ARM: ep93xx: i2s: Add IRQ to platform device resources
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

According to "EP93xx User???s Guide" it's called I2SINTR and has number 60.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/mach-ep93xx/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index e70feec6fad5..48d6a9e01dc8 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -635,6 +635,7 @@ EXPORT_SYMBOL(ep93xx_keypad_release_gpio);
  *************************************************************************/
 static struct resource ep93xx_i2s_resource[] = {
 	DEFINE_RES_MEM(EP93XX_I2S_PHYS_BASE, 0x100),
+	DEFINE_RES_IRQ(IRQ_EP93XX_SAI),
 };
 
 static struct platform_device ep93xx_i2s_device = {
-- 
2.17.0
