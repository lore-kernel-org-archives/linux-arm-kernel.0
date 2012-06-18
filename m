From: mturquette@ti.com (Mike Turquette)
Date: Mon, 18 Jun 2012 13:04:42 -0700
Subject: [PATCH 01/29] clk: Add support for rate table based dividers
In-Reply-To: <1339678038-23082-2-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <1339678038-23082-2-git-send-email-rnayak@ti.com>
Message-ID: <20120618200442.GA4402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120614-18:16, Rajendra Nayak wrote:
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index e548c43..e4911ee 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -32,30 +32,69 @@
>  #define div_mask(d)	((1 << (d->width)) - 1)
>  #define is_power_of_two(i)	!(i & ~i)
>  
> +static unsigned int _get_table_maxdiv(const struct clk_div_table *table)
> +{
> +	unsigned int maxdiv;
> +	const struct clk_div_table *clkt;
> +
> +	for (clkt = table; clkt->div; clkt++)
> +		if (clkt->div > maxdiv)
> +			maxdiv = clkt->div;
> +	return maxdiv;
> +}
> +

Hi Rajendra,

During testing the compiler warns that maxdiv is uninitialized here.

Regards,
Mike
