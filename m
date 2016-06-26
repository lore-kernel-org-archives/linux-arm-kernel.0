From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 26 Jun 2016 02:45:57 +0200
Subject: [PATCH v3 5/8] rtc: ac100: Add clk output support
In-Reply-To: <1466391138-12862-6-git-send-email-wens@csie.org>
References: <1466391138-12862-1-git-send-email-wens@csie.org>
 <1466391138-12862-6-git-send-email-wens@csie.org>
Message-ID: <20160626004557.GX5809@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/2016 at 10:52:15 +0800, Chen-Yu Tsai wrote :
> +struct ac100_clk32k {
> +	struct clk_hw hw;
> +	struct regmap *regmap;
> +	u8 offset;
> +};
> +
> +#define to_ac100_clk32k(_hw) container_of(_hw, struct ac100_clk32k, hw)
> +
> +#define AC100_RTC_32K_NAME	"ac100-rtc-32k"
> +#define AC100_RTC_32K_RATE	32768
> +#define AC100_ADDA_4M_NAME	"ac100-adda-4M"
> +#define AC100_ADDA_4M_RATE	4000000
> +#define AC100_CLK32K_NUM	3
> +
> +static const char * const ac100_clk32k_names[] = {
> +	"ac100-clk32k-ap",
> +	"ac100-clk32k-bb",
> +	"ac100-clk32k-md",
> +};
> +

Well, naming things is hard but I don't feel ac100_clk32k and
ac100-clk32k are good prefixes for those clocks as they are actually
dividing a 32KHz or 4MHz clock (one configuration out of 128 is 32KHz).

Else, I don't have any objection.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
