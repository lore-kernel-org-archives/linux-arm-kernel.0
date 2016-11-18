From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Fri, 18 Nov 2016 15:53:20 -0800
Subject: [PATCH] pinctrl: mediatek: use builtin_platform_driver
In-Reply-To: <70fcc58b7e9219a9fbe3695df927041b8234dd08.1479457060.git.geliangtang@gmail.com>
References: <7746cfe83ca3e96ccdf503669db3ace0e3081b7f.1479455552.git.geliangtang@gmail.com>
 <70fcc58b7e9219a9fbe3695df927041b8234dd08.1479457060.git.geliangtang@gmail.com>
Message-ID: <1479513200.25135.0.camel@mussux00>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-11-18 at 22:12 +0800, Geliang Tang wrote:
> Use builtin_platform_driver() helper to simplify the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mt6397.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6397.c b/drivers/pinctrl/mediatek/pinctrl-mt6397.c
> index 6eccb85..afcede7 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt6397.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt6397.c
> @@ -64,8 +64,4 @@ static struct platform_driver mtk_pinctrl_driver = {
>  	},
>  };
>  
> -static int __init mtk_pinctrl_init(void)
> -{
> -	return platform_driver_register(&mtk_pinctrl_driver);
> -}
> -device_initcall(mtk_pinctrl_init);
> +builtin_platform_driver(mtk_pinctrl_driver);

Acked-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Thanks,
Hongzhou
