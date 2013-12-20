From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 21 Dec 2013 09:35:50 +1300
Subject: [PATCH Resend 5/7] clk: vt8500: Staticize vtwm_pll_ops
In-Reply-To: <1387443241-5694-5-git-send-email-sachin.kamat@linaro.org>
References: <1387443241-5694-1-git-send-email-sachin.kamat@linaro.org>
 <1387443241-5694-5-git-send-email-sachin.kamat@linaro.org>
Message-ID: <52B4AA26.6080401@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/12/13 21:53, Sachin Kamat wrote:
> 'vtwm_pll_ops' is local to this file. Make it static.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Tony Prisk <linux@prisktech.co.nz>
> ---
>   drivers/clk/clk-vt8500.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
> index 7fd5c5e9e25d..37e928846ec5 100644
> --- a/drivers/clk/clk-vt8500.c
> +++ b/drivers/clk/clk-vt8500.c
> @@ -641,7 +641,7 @@ static unsigned long vtwm_pll_recalc_rate(struct clk_hw *hw,
>   	return pll_freq;
>   }
>   
> -const struct clk_ops vtwm_pll_ops = {
> +static const struct clk_ops vtwm_pll_ops = {
>   	.round_rate = vtwm_pll_round_rate,
>   	.set_rate = vtwm_pll_set_rate,
>   	.recalc_rate = vtwm_pll_recalc_rate,
I thought I had already ack'd this but if not:

Acked-by: Tony Prisk <linux@prisktech.co.nz>

Regards
Tony Prisk
