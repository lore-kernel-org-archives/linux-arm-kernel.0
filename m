From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 8 Oct 2012 12:56:41 +0200
Subject: [PATCH] ARM: imx: fix the return value check in
 imx_clk_busy_divider()
In-Reply-To: <CAPgLHd-0wYjWxWrmLdc+an0RVfEicv3QBEtvsuvQtphti3phdw@mail.gmail.com>
References: <CAPgLHd-0wYjWxWrmLdc+an0RVfEicv3QBEtvsuvQtphti3phdw@mail.gmail.com>
Message-ID: <20121008105641.GP1322@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 02:14:25PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function clk_register() returns ERR_PTR()
> no NULL pointer. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> dpatch engine is used to auto generated this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied, thanks

Sascha

> ---
>  arch/arm/mach-imx/clk-busy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/clk-busy.c b/arch/arm/mach-imx/clk-busy.c
> index 1a7a8dd..1ab91b5 100644
> --- a/arch/arm/mach-imx/clk-busy.c
> +++ b/arch/arm/mach-imx/clk-busy.c
> @@ -108,7 +108,7 @@ struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
>  	busy->div.hw.init = &init;
>  
>  	clk = clk_register(NULL, &busy->div.hw);
> -	if (!clk)
> +	if (IS_ERR(clk))
>  		kfree(busy);
>  
>  	return clk;
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
