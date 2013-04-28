From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 28 Apr 2013 10:56:28 +0200
Subject: [PATCH 1/2] clk: si5351: Fix clkout rate computation.
In-Reply-To: <1366698170-31346-1-git-send-email-marek.belisko@streamunlimited.com>
References: <1366698170-31346-1-git-send-email-marek.belisko@streamunlimited.com>
Message-ID: <517CE43C.3080003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2013 08:22 AM, Marek Belisko wrote:
> Rate was incorrectly computed because we read from wrong divider register.
>
> Signed-off-by: Marek Belisko<marek.belisko@streamunlimited.com>

Marek,

sorry for the late reply and very good catch!

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   drivers/clk/clk-si5351.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
> index 8927284..cf39e53 100644
> --- a/drivers/clk/clk-si5351.c
> +++ b/drivers/clk/clk-si5351.c
> @@ -932,7 +932,7 @@ static unsigned long si5351_clkout_recalc_rate(struct clk_hw *hw,
>   	unsigned char reg;
>   	unsigned char rdiv;
>
> -	if (hwdata->num>  5)
> +	if (hwdata->num<= 5)
>   		reg = si5351_msynth_params_address(hwdata->num) + 2;
>   	else
>   		reg = SI5351_CLK6_7_OUTPUT_DIVIDER;
