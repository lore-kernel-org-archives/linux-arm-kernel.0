From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 31 May 2014 03:21:17 +0900
Subject: [PATCH] arm: exynos: Enable mcpm for dual-cluster 5800 SoC
In-Reply-To: <1401083676-25660-1-git-send-email-a.kesavan@samsung.com>
References: <1401083676-25660-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <5388CC1D.8060301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/14 14:54, Abhilash Kesavan wrote:
> 5800 is very similar to 5420. We can re-use the existing
> MCPM support for 5800 for secondary boot-up and switching.
>
> Signed-off-by: Abhilash Kesavan<a.kesavan@samsung.com>
> ---
>   arch/arm/mach-exynos/mcpm-exynos.c |    8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
> index 1ac618c..20707bd 100644
> --- a/arch/arm/mach-exynos/mcpm-exynos.c
> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> @@ -290,13 +290,19 @@ static void __naked exynos_pm_power_up_setup(unsigned int affinity_level)
>   	"b	cci_enable_port_for_self");
>   }
>
> +static const struct of_device_id exynos_dt_mcpm_match[] = {
> +	{ .compatible = "samsung,exynos5420" },
> +	{ .compatible = "samsung,exynos5800" },
> +	{},
> +};
> +
>   static int __init exynos_mcpm_init(void)
>   {
>   	struct device_node *node;
>   	void __iomem *ns_sram_base_addr;
>   	int ret;
>
> -	node = of_find_compatible_node(NULL, NULL, "samsung,exynos5420");
> +	node = of_find_matching_node(NULL, exynos_dt_mcpm_match);
>   	if (!node)
>   		return -ENODEV;
>   	of_node_put(node);

Applied, thanks.

- Kukjin
