From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 15 Jun 2014 22:30:58 +0200
Subject: [PATCH] Frees gate after if statement in clk-sunxi.c
In-Reply-To: <1402769508-3821-1-git-send-email-xerofoify@gmail.com>
References: <1402769508-3821-1-git-send-email-xerofoify@gmail.com>
Message-ID: <20140615203058.GA22265@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 14, 2014 at 02:11:48PM -0400, Nick wrote:
> Signed-off-by: Nick <xerofoify@gmail.com>

This should be your full real name here.

> ---
>  drivers/clk/sunxi/clk-sunxi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 4264834..6f4fc51 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -42,6 +42,7 @@ static void __init sun4i_osc_clk_setup(struct device_node *node)
>  	u32 rate;
>  
>  	if (of_property_read_u32(node, "clock-frequency", &rate))
> +		kree(gate);

There's a typo in kfree. How does that even compile?

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140615/ff1118cc/attachment.sig>
