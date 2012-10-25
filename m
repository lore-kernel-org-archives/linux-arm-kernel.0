From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 25 Oct 2012 17:47:45 +0200
Subject: [PATCH] ARM i.MX: fix error-valued pointer dereference in
 clk_register_gate2()
In-Reply-To: <CAPgLHd9Q3bZVth2NSxwH6kBpPsBmRGD+4pfZRpWL69KCw4HY4g@mail.gmail.com>
References: <CAPgLHd9Q3bZVth2NSxwH6kBpPsBmRGD+4pfZRpWL69KCw4HY4g@mail.gmail.com>
Message-ID: <20121025154745.GG27665@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 11:02:18PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> The error-valued pointer clk is used for the arg of kfree, it should be
> kfree(gate) if clk_register() return ERR_PTR().
> 
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied, thanks

Sascha

> ---
>  arch/arm/mach-imx/clk-gate2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/clk-gate2.c b/arch/arm/mach-imx/clk-gate2.c
> index 3c1b8ff..cc49c7a 100644
> --- a/arch/arm/mach-imx/clk-gate2.c
> +++ b/arch/arm/mach-imx/clk-gate2.c
> @@ -112,7 +112,7 @@ struct clk *clk_register_gate2(struct device *dev, const char *name,
>  
>  	clk = clk_register(dev, &gate->hw);
>  	if (IS_ERR(clk))
> -		kfree(clk);
> +		kfree(gate);
>  
>  	return clk;
>  }
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
