From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Apr 2013 13:36:21 +0200
Subject: [PATCH 03/23] ARM: u300: device tree support for the timer
In-Reply-To: <1366624304-6190-1-git-send-email-linus.walleij@stericsson.com>
References: <1366624304-6190-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201304221336.21921.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 April 2013, Linus Walleij wrote:
> +#ifdef CONFIG_OF
> +       struct device_node *timer = NULL;
> +
> +       timer = of_find_node_by_path("/timer0 at c0014000");
> +       if (timer) {
> +               struct resource irq_res;
> +
> +               u300_timer_base = of_iomap(timer, 0);
> +               /* Get the IRQ for the GP1 timer */
> +               irq = of_irq_to_resource(timer, 2, &irq_res);
> +       }
> +#endif

Do you need the #ifdef? The functions should be defined in a way that
removes this code if CONFIG_OF is not defined.

	Arnd
