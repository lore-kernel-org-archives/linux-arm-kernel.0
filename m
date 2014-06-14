From: linux@baker-net.org.uk (Adam Baker)
Date: Sat, 14 Jun 2014 23:06:23 +0100
Subject: [PATCH] Frees gate after if statement in clk-sunxi.c
In-Reply-To: <1402769508-3821-1-git-send-email-xerofoify@gmail.com>
References: <1402769508-3821-1-git-send-email-xerofoify@gmail.com>
Message-ID: <539CC75F.2080105@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/06/14 19:11, Nick wrote:
> Signed-off-by: Nick <xerofoify@gmail.com>
> ---
>   drivers/clk/sunxi/clk-sunxi.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 4264834..6f4fc51 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -42,6 +42,7 @@ static void __init sun4i_osc_clk_setup(struct device_node *node)
>   	u32 rate;
>
>   	if (of_property_read_u32(node, "clock-frequency", &rate))
> +		kree(gate);
>   		return;

There are no braces around this so the function of this code as written 
is an unconditional return and the return shouldn't be indented. I 
suspect, without reading the rest of the file, that that isn't what you 
intended.

>
>   	/* allocate fixed-rate and gate clock structs */
>

Adam
