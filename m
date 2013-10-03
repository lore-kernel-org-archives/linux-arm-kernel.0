From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Thu, 3 Oct 2013 15:52:17 -0500
Subject: [PATCH] imx6q: fix emergency restart
In-Reply-To: <1380832337-4637-1-git-send-email-nathan_lynch@mentor.com>
References: <1380832337-4637-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <524DD901.8090909@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/2013 03:32 PM, Nathan Lynch wrote:
>  static void __init imx6q_init_machine(void)
>  {
> +	struct device_node *np;
> +
>  	imx6q_enet_phy_init();
>  
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-wdt");
> +	if (np)
> +		wdog_base = of_iomap(np, 0);
> +	pr_info("%s: wdog_base = %p\n", __func__, wdog_base);
> +

I'll remove this stray debug statement in v2 after waiting a while for
any other comments.
