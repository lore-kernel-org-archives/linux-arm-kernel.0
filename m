From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Nov 2012 15:55:53 +0000
Subject: [PATCH 4/4] ARM: sunxi: Add sunxi restart function via onchip
 watchdog
In-Reply-To: <1353323383-11827-4-git-send-email-sr@denx.de>
References: <1353323383-11827-1-git-send-email-sr@denx.de>
 <1353323383-11827-4-git-send-email-sr@denx.de>
Message-ID: <201211191555.53378.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 November 2012, Stefan Roese wrote:
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> +void sunxi_restart(char mode, const char *cmd)
> +{
> +	/* Use watchdog to reset system */
> +
> +	/* Enable timer and set reset bit */
> +	writel(3, timer_base + WATCH_DOG_MODE_REG);
> +	writel(0xa57 << 1 | 1, timer_base + WATCH_DOG_CTRL_REG);
> +
> +	while(1)
> +		;
> +}
> +
>  static void __init sunxi_timer_init(void)
>  {
>  	struct device_node *node;

We may have to revisit this if we get to the point where timer drivers
can be in loadable modules. We can't do that yet, so it's probably
better the way you wrote it than something else.

	Arnd
