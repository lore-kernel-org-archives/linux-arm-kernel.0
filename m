From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 30 Jan 2013 13:48:40 +0800
Subject: [RFC 3/3] arm: mach-mxs: make enabling enet_out a legacy function
In-Reply-To: <1359470773-14290-4-git-send-email-w.sang@pengutronix.de>
References: <1359470773-14290-1-git-send-email-w.sang@pengutronix.de>
 <1359470773-14290-4-git-send-email-w.sang@pengutronix.de>
Message-ID: <20130130054833.GA24450@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 03:46:13PM +0100, Wolfram Sang wrote:
> @@ -351,7 +359,7 @@ static void __init tx28_post_init(void)
>  	struct pinctrl *pctl;
>  	int ret;
>  
> -	enable_clk_enet_out();
> +	legacy_enable_clk_enet_out();

I think TX28 is the only case that really needs to turn on enet_out
clock at platform level, since it has some dirty work about PHY to do
here.  With with fec driver handling the clock, enable_clk_enet_out()
can just be removed for other boards.

Shawn

>  
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx28-fec");
>  	pdev = of_find_device_by_node(np);
