From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 28 May 2018 08:50:43 +0200
Subject: [PATCH] mmc: sunxi: mark PM functions as __maybe_unused
In-Reply-To: <20180525210752.1794502-1-arnd@arndb.de>
References: <20180525210752.1794502-1-arnd@arndb.de>
Message-ID: <20180528065043.yewyrrat2eqlm2sa@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 11:07:42PM +0200, Arnd Bergmann wrote:
> The newly added runtime-pm functions cause a harmless warning
> when CONFIG_PM is disabled:
> 
> drivers/mmc/host/sunxi-mmc.c:1452:12: error: 'sunxi_mmc_runtime_suspend' defined but not used [-Werror=unused-function]
>  static int sunxi_mmc_runtime_suspend(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mmc/host/sunxi-mmc.c:1435:12: error: 'sunxi_mmc_runtime_resume' defined but not used [-Werror=unused-function]
>  static int sunxi_mmc_runtime_resume(struct device *dev)
> 
> This marks them as __maybe_unused to shut up the warning.
> 
> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180528/7e148807/attachment.sig>
