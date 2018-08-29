From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 29 Aug 2018 10:15:20 +0800
Subject: [PATCH] pinctrl: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <20180828015252.28511-40-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-40-robh@kernel.org>
Message-ID: <CAGb2v64Hy-RQiXBhYrcy7FtNnqRUOhwGNZc8jko=FVrDDUH_hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 9:55 AM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-mediatek at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-amlogic at lists.infradead.org
> Cc: linux-rockchip at lists.infradead.org
> Cc: linux-omap at vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pinctrl/berlin/berlin.c               |  6 ++--
>  drivers/pinctrl/freescale/pinctrl-imx.c       |  7 ++--
>  drivers/pinctrl/freescale/pinctrl-imx1-core.c | 12 +++----
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  4 +--
>  drivers/pinctrl/meson/pinctrl-meson.c         |  2 +-
>  drivers/pinctrl/mvebu/pinctrl-mvebu.c         |  4 +--
>  drivers/pinctrl/nomadik/pinctrl-nomadik.c     |  6 ++--
>  drivers/pinctrl/pinctrl-at91.c                |  8 ++---
>  drivers/pinctrl/pinctrl-lantiq.c              |  8 ++---
>  drivers/pinctrl/pinctrl-rockchip.c            |  8 ++---
>  drivers/pinctrl/pinctrl-rza1.c                |  8 ++---
>  drivers/pinctrl/pinctrl-single.c              | 32 +++++++++----------
>  drivers/pinctrl/pinctrl-st.c                  |  6 ++--
>  drivers/pinctrl/sirf/pinctrl-atlas7.c         |  4 +--
>  drivers/pinctrl/stm32/pinctrl-stm32.c         |  4 +--
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c         |  8 ++---

For sunxi:

Acked-by: Chen-Yu Tsai <wens@csie.org>
