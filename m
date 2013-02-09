From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 09 Feb 2013 14:20:14 +0000
Subject: linux-next: manual merge of the samsung tree with the arm-soc tree
In-Reply-To: <20130131014801.09c81e1826a2fb234de85550@canb.auug.org.au>
References: <20130131014801.09c81e1826a2fb234de85550@canb.auug.org.au>
Message-ID: <20130209142014.208ED3E30EC@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 31 Jan 2013 01:48:01 +1100, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Kukjin,
> 
> Today's linux-next merge of the samsung tree got a conflict in
> drivers/gpio/gpio-samsung.c between commits f69254328793 ("ARM: dts: Fix
> compatible value of pinctrl module on EXYNOS5440") and b533c8685b16
> ("ARM: dts: fix compatible value for exynos pinctrl") from the arm-soc
> tree and commit bda7f6d4e198 ("gpio: samsung: skip gpiolib registration
> if pinctrl support is enabled for exynos5250") from the samsung tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Thanks Stephen.

g.

> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
> 
> diff --cc drivers/gpio/gpio-samsung.c
> index b2016ed,0d46db6..0000000
> --- a/drivers/gpio/gpio-samsung.c
> +++ b/drivers/gpio/gpio-samsung.c
> @@@ -3023,9 -3023,9 +3022,10 @@@ static __init int samsung_gpiolib_init(
>   	*/
>   	struct device_node *pctrl_np;
>   	static const struct of_device_id exynos_pinctrl_ids[] = {
>  -		{ .compatible = "samsung,pinctrl-exynos4210", },
>  -		{ .compatible = "samsung,pinctrl-exynos4x12", },
>  -		{ .compatible = "samsung,pinctrl-exynos5250", },
>  +		{ .compatible = "samsung,exynos4210-pinctrl", },
>  +		{ .compatible = "samsung,exynos4x12-pinctrl", },
> ++		{ .compatible = "samsung,exynos5250-pinctrl", },
>  +		{ .compatible = "samsung,exynos5440-pinctrl", },
>   	};
>   	for_each_matching_node(pctrl_np, exynos_pinctrl_ids)
>   		if (pctrl_np && of_device_is_available(pctrl_np))
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
