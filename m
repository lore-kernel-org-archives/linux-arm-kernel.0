From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 11 May 2016 18:05:33 +0200
Subject: [PATCH] drm: mediatek: add COMMON_CLK dependency
In-Reply-To: <1462970100-240687-1-git-send-email-arnd@arndb.de>
References: <1462970100-240687-1-git-send-email-arnd@arndb.de>
Message-ID: <1462982733.2924.36.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 11.05.2016, 14:34 +0200 schrieb Arnd Bergmann:
> On kernel builds without COMMON_CLK, the newly added mediatek drm
> driver fails to build:
> 
> drivers/gpu/drm/mediatek/mtk_mipi_tx.c:130:16: error: field 'pll_hw' has incomplete type
>   struct clk_hw pll_hw;
>                 ^~~~~~
> In file included from ../include/linux/clk.h:16:0,
>                  from ../drivers/gpu/drm/mediatek/mtk_mipi_tx.c:14:
> drivers/gpu/drm/mediatek/mtk_mipi_tx.c: In function 'mtk_mipi_tx_from_clk_hw':
> include/linux/kernel.h:831:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>   const typeof( ((type *)0)->member ) *__mptr = (ptr); \
>                                                 ^
> /drivers/gpu/drm/mediatek/mtk_mipi_tx.c:136:9: note: in expansion of macro 'container_of'
>   return container_of(hw, struct mtk_mipi_tx, pll_hw);
>          ^~~~~~~~~~~~
> drivers/gpu/drm/mediatek/mtk_mipi_tx.c: At top level:
> drivers/gpu/drm/mediatek/mtk_mipi_tx.c:302:21: error: variable 'mtk_mipi_tx_pll_ops' has initializer but incomplete type
>  static const struct clk_ops mtk_mipi_tx_pll_ops = {
> 
> This adds the required Kconfig dependency.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
