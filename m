From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Feb 2012 13:40:48 +0000
Subject: [PATCH 2/2] GPIO: LPC32xx: Add output reading to GPO P3
In-Reply-To: <1329773948-4655-2-git-send-email-stigge@antcom.de>
References: <1329773948-4655-1-git-send-email-stigge@antcom.de>
 <1329773948-4655-2-git-send-email-stigge@antcom.de>
Message-ID: <201202231340.48558.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 February 2012, Roland Stigge wrote:
> The chip offers the function to detect the current state of output of the GPO
> P3 pins. Useful for reading GPIO output state in Linux' GPIO API, e.g. via
> sysfs
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

> +static int __get_gpo_state_p3(struct lpc32xx_gpio_chip *group,
> +       unsigned pin)
> +{
> +       return GPO3_PIN_IN_SEL(__raw_readl(group->gpio_grp->outp_state), pin);
> +}
> +

It would be nice to convert this to use readl_relaxed() everywhere instead
of __raw_readl(), but that is probably better done separately.

	Arnd
