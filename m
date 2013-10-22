From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Tue, 22 Oct 2013 05:45:23 -0500
Subject: [PATCH] clk: socfpga: Remove check for "reg" property in
 socfpga_clk_init
In-Reply-To: <1381797274-4564-1-git-send-email-dinguyen@altera.com>
References: <1381797274-4564-1-git-send-email-dinguyen@altera.com>
Message-ID: <52665743.1000309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 10/14/13 7:34 PM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
>
> The function socfpga_clk_init() can support clocks that do not have a divider
> register, but a fixed-divider that can be read from DTS. Therefore, the "reg"
> property is not a failing condition for socfpga_clk_init().
>
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>   drivers/clk/socfpga/clk.c |    4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
> index 5bb848c..7f846bf 100644
> --- a/drivers/clk/socfpga/clk.c
> +++ b/drivers/clk/socfpga/clk.c
> @@ -121,9 +121,7 @@ static __init struct clk *socfpga_clk_init(struct device_node *node,
>   	int rc;
>   	u32 fixed_div;
>   
> -	rc = of_property_read_u32(node, "reg", &reg);
> -	if (WARN_ON(rc))
> -		return NULL;
> +	of_property_read_u32(node, "reg", &reg);
>   
>   	socfpga_clk = kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
>   	if (WARN_ON(!socfpga_clk))
Was wondering if you have gotten a chance to review this patch?

Thanks,
Dinh
