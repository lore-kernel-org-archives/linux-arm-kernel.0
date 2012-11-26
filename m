From: stigge@antcom.de (Roland Stigge)
Date: Mon, 26 Nov 2012 15:44:06 +0100
Subject: [PATCH] ARM: use clockevents_config_and_register() where possible
In-Reply-To: <1353936857-15313-1-git-send-email-shawn.guo@linaro.org>
References: <1353936857-15313-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <50B38036.9000500@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2012 02:34 PM, Shawn Guo wrote:
> The clockevent core is able to figure out the best mult and shift,
> calculate min_delta_ns and max_delta_ns, with the necessary info passed
> into clockevents_config_and_register().  Use this combined configure
> and register function where possible to make the codes less error prone
> and gain some positive diff stat.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Anton Vorontsov <cbouatmailru@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Roland Stigge <stigge@antcom.de>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Barry Song <baohua.song@csr.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Tony Prisk <linux@prisktech.co.nz>
> Cc: Lennert Buytenhek <buytenh@wantstofly.org>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> ---
>  arch/arm/mach-at91/at91rm9200_time.c     |    7 ++-----
>  arch/arm/mach-cns3xxx/core.c             |   13 +++----------
>  arch/arm/mach-exynos/mct.c               |   18 ++++--------------
>  arch/arm/mach-footbridge/dc21285-timer.c |    6 +-----
>  arch/arm/mach-imx/epit.c                 |   15 +++------------
>  arch/arm/mach-imx/time.c                 |   15 +++------------
>  arch/arm/mach-ixp4xx/common.c            |   11 ++---------
>  arch/arm/mach-lpc32xx/timer.c            |    9 +--------

On LPC32xx:

Tested-by: Roland Stigge <stigge@antcom.de>

Thanks!

Roland

>  arch/arm/mach-mmp/time.c                 |    7 ++-----
>  arch/arm/mach-msm/timer.c                |    6 +-----
>  arch/arm/mach-mxs/timer.c                |   24 +++++-------------------
>  arch/arm/mach-netx/time.c                |   10 ++--------
>  arch/arm/mach-omap1/time.c               |   11 ++---------
>  arch/arm/mach-omap1/timer32k.c           |   12 ++----------
>  arch/arm/mach-omap2/timer.c              |   13 +++----------
>  arch/arm/mach-prima2/timer.c             |   10 ++--------
>  arch/arm/mach-pxa/time.c                 |    8 ++------
>  arch/arm/mach-sa1100/time.c              |    8 ++------
>  arch/arm/mach-tegra/timer.c              |    8 ++------
>  arch/arm/mach-vt8500/timer.c             |    9 ++-------
>  arch/arm/mach-w90x900/time.c             |   10 ++--------
>  arch/arm/plat-iop/time.c                 |    9 ++-------
>  arch/arm/plat-orion/time.c               |    6 +-----
>  arch/arm/plat-samsung/s5p-time.c         |    9 +--------
>  arch/arm/plat-spear/time.c               |    8 +-------
>  25 files changed, 53 insertions(+), 209 deletions(-)
