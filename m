From: joe@perches.com (Joe Perches)
Date: Fri, 19 Jul 2013 12:12:11 -0700
Subject: [PATCH 2/2] clk/zynq/pll: Use #defines for fbdiv min/max values
In-Reply-To: <1632076624.115.1374260902674.JavaMail.mail@webmail02>
References: <1374254205-9912-1-git-send-email-soren.brinkmann@xilinx.com>
 <1632076624.115.1374260902674.JavaMail.mail@webmail02>
Message-ID: <1374261131.2059.5.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-07-19 at 10:16 -0700, Soren Brinkmann wrote:
> Use more descriptive #defines for the minimum and maximum PLL
> feedback divider.

trivial

> diff --git a/drivers/clk/zynq/pll.c b/drivers/clk/zynq/pll.c
[]
> @@ -63,10 +66,10 @@ static long zynq_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>  	u32 fbdiv;
>  
>  	fbdiv = DIV_ROUND_CLOSEST(rate, *prate);
> -	if (fbdiv < 13)
> -		fbdiv = 13;
> -	else if (fbdiv > 66)
> -		fbdiv = 66;
> +	if (fbdiv < PLL_FBDIV_MIN)
> +		fbdiv = PLL_FBDIV_MIN;
> +	else if (fbdiv > PLL_FBDIV_MAX)
> +		fbdiv = PLL_FBDIV_MAX;

clamp
