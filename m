From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 07 Oct 2010 15:15:23 +0400
Subject: [PATCH 2/4] omap4: pandaboard: Fix the init if CONFIG_MMC_OMAP_HS
	is	not set
In-Reply-To: <1286400020-1010-3-git-send-email-x0132446@ti.com>
References: <1286400020-1010-1-git-send-email-x0132446@ti.com>
	<1286400020-1010-3-git-send-email-x0132446@ti.com>
Message-ID: <4CADABCB.6060906@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07-10-2010 1:20, David Anders wrote:

> Avoid possible crash if CONFIG_MMC_OMAP_HS is not set.

> Signed-off-by: David Anders<x0132446@ti.com>
> Signed-off-by: Anand Gadiyar<gadiyar@ti.com>
[...]

> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index 093d13b..697c0bd 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -85,7 +85,14 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)
>
>   static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
>   {
> -	struct omap_mmc_platform_data *pdata = dev->platform_data;
> +	struct omap_mmc_platform_data *pdata;
> +
> +	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */

    s/null/NULL/?

> +	if (!dev) {
> +		pr_err("Failed omap4_twl6030_hsmmc_set_late_init\n");

    pr_err("Failed %s\n", __func__);

WBR, Sergei
