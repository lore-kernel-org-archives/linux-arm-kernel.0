From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 7 Feb 2014 11:02:39 +0100
Subject: [PATCH] clk: at91: remove redundant assignment
In-Reply-To: <1391712790-13591-1-git-send-email-colin.king@canonical.com>
References: <1391712790-13591-1-git-send-email-colin.king@canonical.com>
Message-ID: <52F4AF3F.7040809@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2014 19:53, Colin King :
> From: Colin Ian King <colin.king@canonical.com>
> 
> remove the redundant shift = shift assignment, it is extraneous.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks.

Boris, can you integrate this patch to the "fixes" series that will be
sent to Mike during the 3.14 development cycle?

Bye,

> ---
>  drivers/clk/at91/clk-programmable.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
> index fd792b2..ff86efe 100644
> --- a/drivers/clk/at91/clk-programmable.c
> +++ b/drivers/clk/at91/clk-programmable.c
> @@ -109,7 +109,7 @@ static long clk_programmable_round_rate(struct clk_hw *hw, unsigned long rate,
>  	unsigned long best_diff;
>  	unsigned long new_diff;
>  	unsigned long cur_rate;
> -	int shift = shift;
> +	int shift;
>  
>  	if (rate > *parent_rate)
>  		return *parent_rate;
> 


-- 
Nicolas Ferre
