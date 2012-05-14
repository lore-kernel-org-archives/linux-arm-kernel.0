From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 14 May 2012 09:04:03 +0530
Subject: [PATCH] clk: SPEAr600: Fix ethernet clock name for DT based
 probing
In-Reply-To: <1336725678-29327-1-git-send-email-sr@denx.de>
References: <1336725678-29327-1-git-send-email-sr@denx.de>
Message-ID: <4FB07D2B.6010409@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/11/2012 2:11 PM, Stefan Roese wrote:
> diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
> index f9a20b3..bf33c1d 100644
> --- a/drivers/clk/spear/spear6xx_clock.c
> +++ b/drivers/clk/spear/spear6xx_clock.c
> @@ -298,7 +298,7 @@ void __init spear6xx_clk_init(void)
>  
>  	clk = clk_register_gate(NULL, "gmac_clk", "ahb_clk", 0, PERIP1_CLK_ENB,
>  			GMAC_CLK_ENB, 0, &_lock);
> -	clk_register_clkdev(clk, NULL, "gmac");
> +	clk_register_clkdev(clk, NULL, "e0800000.ethernet");
>  
>  	clk = clk_register_gate(NULL, "i2c_clk", "ahb_clk", 0, PERIP1_CLK_ENB,
>  			I2C_CLK_ENB, 0, &_lock);

Acked-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
