From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 8 Oct 2012 11:25:47 +0200
Subject: [PATCH] ARM: imx: fix return value check in imx3_init_l2x0()
In-Reply-To: <CAPgLHd8Rma5fSWPtjvLr18TEmmC=8kOjmSJtneO0Ecd1bvOrcg@mail.gmail.com>
References: <CAPgLHd8Rma5fSWPtjvLr18TEmmC=8kOjmSJtneO0Ecd1bvOrcg@mail.gmail.com>
Message-ID: <20121008092547.GK1322@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 01:54:01PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function ioremap() returns NULL
> not ERR_PTR(). The IS_ERR() test in the return value
> check should be replaced with NULL test.
> 
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Appied, thanks

Sascha


> ---
>  arch/arm/mach-imx/mm-imx3.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
> index 9d2c843..b5deb05 100644
> --- a/arch/arm/mach-imx/mm-imx3.c
> +++ b/arch/arm/mach-imx/mm-imx3.c
> @@ -108,9 +108,8 @@ void __init imx3_init_l2x0(void)
>  	}
>  
>  	l2x0_base = ioremap(MX3x_L2CC_BASE_ADDR, 4096);
> -	if (IS_ERR(l2x0_base)) {
> -		printk(KERN_ERR "remapping L2 cache area failed with %ld\n",
> -				PTR_ERR(l2x0_base));
> +	if (!l2x0_base) {
> +		printk(KERN_ERR "remapping L2 cache area failed\n");
>  		return;
>  	}
>  
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
