From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 May 2013 11:19:21 +0100
Subject: [PATCH V2 1/6] drivers: bus: add a new driver for WEIM
In-Reply-To: <1369296978-7669-2-git-send-email-b32955@freescale.com>
References: <1369296978-7669-1-git-send-email-b32955@freescale.com>
 <1369296978-7669-2-git-send-email-b32955@freescale.com>
Message-ID: <20130523101921.GM18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 04:16:13PM +0800, Huang Shijie wrote:
> +	/* get the clock */
> +	weim->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(weim->clk))
> +		goto weim_err;
> +
> +	clk_prepare_enable(weim->clk);

I notice people are getting lazy about this.  clk_prepare_enable() can
return an error...
