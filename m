From: jdelvare@suse.de (Jean Delvare)
Date: Tue, 26 Sep 2017 08:00:22 +0200
Subject: [PATCH] soc: mediatek: turn MTK_PMIC_WRAP into visible symbols
In-Reply-To: <6c1696cf9f860cc8151a906ecbc799121b5aeeab.1505984256.git.sean.wang@mediatek.com>
References: <6c1696cf9f860cc8151a906ecbc799121b5aeeab.1505984256.git.sean.wang@mediatek.com>
Message-ID: <20170926080022.215f7b7b@endymion>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Sep 2017 17:01:05 +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> MTK_PMIC_WRAP is the basic and required configuration for those various
> MediaTek PMICs, so turning MTK_PMIC_WRAP into visible symbols easily
> allows users tending to have the enablement for those PMICs.

I can't really make sense of the sentence above, sorry, and can't see
how it matches the change below anyway. MTK_PMIC_WRAP is already a
visible symbol before this change. The change is probably good in
itself, but please try to come up with a better description.

> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index a2fcd7f..d513629 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -15,7 +15,7 @@ config MTK_INFRACFG
>  config MTK_PMIC_WRAP
>  	tristate "MediaTek PMIC Wrapper Support"
>  	depends on ARCH_MEDIATEK
> -	depends on RESET_CONTROLLER
> +	select RESET_CONTROLLER
>  	select REGMAP
>  	help
>  	  Say yes here to add support for MediaTek PMIC Wrapper found


-- 
Jean Delvare
SUSE L3 Support
