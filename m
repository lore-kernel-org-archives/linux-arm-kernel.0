From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Jul 2013 21:38:29 +0200
Subject: [PATCH v1 05/24] clk: wrap I/O access for improved portability
In-Reply-To: <1373914074-20889-6-git-send-email-gsi@denx.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1373914074-20889-6-git-send-email-gsi@denx.de>
Message-ID: <20130715193829.GS14452@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 08:47:34PM +0200, Gerhard Sittig wrote:
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index 6d55eb2..2c07061 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -104,7 +104,7 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
>  	struct clk_divider *divider = to_clk_divider(hw);
>  	unsigned int div, val;
>  
> -	val = readl(divider->reg) >> divider->shift;
> +	val = clk_readl(divider->reg) >> divider->shift;
>  	val &= div_mask(divider);

Would it be an option to use regmap for the generic dividers/muxes
instead? This should be suitable for ppc and also for people who want to
use the generic clocks on i2c devices.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
