From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 28 May 2018 11:19:30 +0200
Subject: [PATCH 1/8] drm/sun4i: mark PM functions as __maybe_unused
In-Reply-To: <20180525155030.3667352-1-arnd@arndb.de>
References: <20180525155030.3667352-1-arnd@arndb.de>
Message-ID: <20180528091930.yjxlgn6ovgxw5r4w@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 05:50:08PM +0200, Arnd Bergmann wrote:
> Disabling CONFIG_PM produces a compile time warning when these
> functions are not referenced:
> 
> drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:1072:12: error: 'sun6i_dsi_runtime_suspend' defined but not used [-Werror=unused-function]
>  static int sun6i_dsi_runtime_suspend(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:1043:12: error: 'sun6i_dsi_runtime_resume' defined but not used [-Werror=unused-function]
>  static int sun6i_dsi_runtime_resume(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: 133add5b5ad4 ("drm/sun4i: Add Allwinner A31 MIPI-DSI controller support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180528/a89240b5/attachment.sig>
