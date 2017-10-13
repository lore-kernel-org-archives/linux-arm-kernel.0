From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 13 Oct 2017 16:57:28 +0200
Subject: [PATCH 1/3] ARM: mediatek: Cocci spatch "of_table"
In-Reply-To: <1505974912018-1713366490-1-diffsplit-thomas@m3y3r.de>
References: <1505974912018-1637125348-0-diffsplit-thomas@m3y3r.de>
 <1505974912018-1713366490-1-diffsplit-thomas@m3y3r.de>
Message-ID: <2060754d-293a-5690-38f3-0d1f170d5c11@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/21/2017 08:24 AM, Thomas Meyer wrote:
> Make sure (of/i2c/platform)_device_id tables are NULL terminated.
> Found by coccinelle spatch "misc/of_table.cocci"
> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
> 

Applied to v4.14-next/soc

Thanks!

> diff -u -p a/arch/arm/mach-mediatek/platsmp.c b/arch/arm/mach-mediatek/platsmp.c
> --- a/arch/arm/mach-mediatek/platsmp.c
> +++ b/arch/arm/mach-mediatek/platsmp.c
> @@ -54,12 +54,14 @@ static const struct of_device_id mtk_tz_
>   	{ .compatible   = "mediatek,mt8135", .data = &mtk_mt8135_tz_boot },
>   	{ .compatible   = "mediatek,mt8127", .data = &mtk_mt8135_tz_boot },
>   	{ .compatible   = "mediatek,mt2701", .data = &mtk_mt8135_tz_boot },
> +	{},
>   };
>   
>   static const struct of_device_id mtk_smp_boot_infos[] __initconst = {
>   	{ .compatible   = "mediatek,mt6589", .data = &mtk_mt6589_boot },
>   	{ .compatible   = "mediatek,mt7623", .data = &mtk_mt7623_boot },
>   	{ .compatible   = "mediatek,mt7623a", .data = &mtk_mt7623_boot },
> +	{},
>   };
>   
>   static void __iomem *mtk_smp_base;
> 
