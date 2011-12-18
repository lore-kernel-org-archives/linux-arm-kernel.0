From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 19 Dec 2011 00:57:25 +0900
Subject: [PATCH v5 REPOST 1/5] ARM: l2x0/pl310: Refactor Kconfig to be
 more maintainable
In-Reply-To: <1324053332-6431-2-git-send-email-dave.martin@linaro.org>
References: <1324053332-6431-1-git-send-email-dave.martin@linaro.org>
 <1324053332-6431-2-git-send-email-dave.martin@linaro.org>
Message-ID: <4EEE0D65.1050700@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/11 01:35, Dave Martin wrote:
> Making CACHE_L2X0 depend on (huge list of MACH_ and ARCH_ configs)
> is bothersome to maintain and likely to lead to merge conflicts.
>
> This patch moves the knowledge of which platforms have a L2x0 or
> PL310 cache controller to the individual machines.  To enable this,
> a new MIGHT_HAVE_CACHE_L2X0 config option is introduced to allow
> machines to indicate that they may have such a cache controller
> independently of each other.
>
> Boards/SoCs which cannot reliably operate without the L2 cache
> controller support will need to select CACHE_L2X0 directly from
> their own Kconfigs instead.  This applies to some TrustZone-enabled
> boards where Linux runs in the Normal World, for example.
>
> Signed-off-by: Dave Martin<dave.martin@linaro.org>
> Acked-by: Anton Vorontsov<cbouatmailru@gmail.com>
>          (for cns3xxx)
> Acked-by: Tony Lindgren<tony@atomide.com>
>          (for omap)
> Acked-by: Shawn Guo<shawn.guo@linaro.org>
>          (for imx)

for exynos:
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

> ---
>   arch/arm/Kconfig               |    8 ++++++++
>   arch/arm/mach-exynos/Kconfig   |    1 +
>   arch/arm/mach-omap2/Kconfig    |    1 +
>   arch/arm/mach-realview/Kconfig |    5 +++++
>   arch/arm/mach-vexpress/Kconfig |    1 +
>   arch/arm/mm/Kconfig            |   23 ++++++++++++++++-------
>   arch/arm/plat-mxc/Kconfig      |    1 +
>   7 files changed, 33 insertions(+), 7 deletions(-)

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
