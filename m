From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Aug 2017 17:06:14 -0500
Subject: [PATCH v2] ARM: Convert to using %pOF instead of full_name
In-Reply-To: <20170721192835.25555-1-robh@kernel.org>
References: <20170721192835.25555-1-robh@kernel.org>
Message-ID: <CAL_JsqJQ7yUhtJca1hupd5zSqo5RTj5k5zc_Ueex1nzbOnjXdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 21, 2017 at 2:28 PM, Rob Herring <robh@kernel.org> wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: "Beno?t Cousson" <bcousson@baylibre.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-omap at vger.kernel.org
> Cc: linux-rockchip at lists.infradead.org
> Cc: linux-renesas-soc at vger.kernel.org
> ---
> v2:
> - Merge several 2 line prints to single line.
> - Add acks
>
>  arch/arm/kernel/cpuidle.c            | 4 ++--
>  arch/arm/kernel/devtree.c            | 5 ++---
>  arch/arm/kernel/topology.c           | 3 +--
>  arch/arm/mach-exynos/suspend.c       | 7 +++----
>  arch/arm/mach-imx/gpc.c              | 4 ++--
>  arch/arm/mach-mvebu/kirkwood.c       | 3 +--
>  arch/arm/mach-omap2/omap-wakeupgen.c | 4 ++--
>  arch/arm/mach-omap2/omap_hwmod.c     | 4 ++--
>  arch/arm/mach-rockchip/platsmp.c     | 4 ++--
>  arch/arm/mach-shmobile/pm-rmobile.c  | 7 +++----
>  10 files changed, 20 insertions(+), 25 deletions(-)

Arnd, Olof,

Can you please apply this one.

Rob
