From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 17 May 2014 01:43:20 +0200
Subject: [PATCH v2 01/11] clk: divider: add CLK_DIVIDER_READ_ONLY flag
In-Reply-To: <1445808.WceTxW3oRk@diego>
References: <3477211.Gkyeur83TV@diego> <1445808.WceTxW3oRk@diego>
Message-ID: <5376A298.6080908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 07.05.2014 23:10, Heiko St?bner wrote:
> Similar to muxes which already have a read-only flag there sometimes
> exist dividers which should not be changed by the clock framework
> but whose value still should be readable.

[snip]

> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 59e2eb5..9c2cf89 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -314,6 +314,8 @@ struct clk_div_table {
>   *   updated to indicate changing divider bits.
>   * CLK_DIVIDER_ROUND_CLOSEST - Makes the best calculated divider to be rounded
>   *	to the closest integer instead of the up one.
> + * CLK_DIVIDER_READ_ONLY - The divider settings are preconfigured and should
> + *	not be changed by the clock framework.
>   */
>  struct clk_divider {
>  	struct clk_hw	hw;
> @@ -330,8 +332,10 @@ struct clk_divider {
>  #define CLK_DIVIDER_ALLOW_ZERO		BIT(2)
>  #define CLK_DIVIDER_HIWORD_MASK		BIT(3)
>  #define CLK_DIVIDER_ROUND_CLOSEST	BIT(4)
> +#define CLK_DIVIDER_READ_ONLY		BIT(4)

Both flags using the same bit? Sounds like a merge conflict.

Otherwise looks good and will be useful for Samsung platforms as well,
so after fixing the above:

Acked-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
