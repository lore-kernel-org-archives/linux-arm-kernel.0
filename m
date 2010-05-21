From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 May 2010 20:22:07 +0100
Subject: [PATCH 3/5] imx_keypad: add PM support
In-Reply-To: <1274440363-435-3-git-send-email-eric@eukrea.com>
References: <1274440363-435-1-git-send-email-eric@eukrea.com>
	<1274440363-435-2-git-send-email-eric@eukrea.com>
	<1274440363-435-3-git-send-email-eric@eukrea.com>
Message-ID: <20100521192207.GE11042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 21, 2010 at 01:12:41PM +0200, Eric B?nard wrote:
> +static int mxc_kpp_resume(struct platform_device *pdev)
> +{
> +	struct imx_keypad *keypad = platform_get_drvdata(pdev);
> +
> +	clk_enable(keypad->clk);
> +	if (device_may_wakeup(&pdev->dev)) {
> +		/* The irq routine already cleared KRIE if it was set */
> +	} else {
> +		enable_irq(keypad->irq);

What happens if an IRQ happens here?

> +		keypad->enabled = true;
