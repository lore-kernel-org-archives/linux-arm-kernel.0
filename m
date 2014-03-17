From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 17 Mar 2014 10:22:41 +0900
Subject: [PATCH] clk: samsung: fixed compiler warning
 [-Wpointer-to-int-cast]
In-Reply-To: <1393382561-5388-1-git-send-email-pankaj.dubey@samsung.com>
References: <1393382561-5388-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <53264E61.2010502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2014 11:42 AM, Pankaj Dubey wrote:
> When compiled using ARM64 cross compiler, gcc complains as
>
> drivers/clk/samsung/clk.c:293:18:
> warning: cast from pointer to integer of different size
> [-Wpointer-to-int-cast]
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>   drivers/clk/samsung/clk.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
> index 91bec3e..59142ba 100644
> --- a/drivers/clk/samsung/clk.c
> +++ b/drivers/clk/samsung/clk.c
> @@ -278,7 +278,7 @@ void __init samsung_clk_of_register_fixed_ext(
>   	for_each_matching_node_and_match(np, clk_matches, &match) {
>   		if (of_property_read_u32(np, "clock-frequency", &freq))
>   			continue;
> -		fixed_rate_clk[(u32)match->data].fixed_rate = freq;
> +		fixed_rate_clk[(unsigned long)match->data].fixed_rate = freq;
>   	}
>   	samsung_clk_register_fixed_rate(fixed_rate_clk, nr_fixed_rate_clk);
>   }

Gentle Ping.

-- 
Best Regards,
Pankaj Dubey
