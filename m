From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 May 2013 12:49:17 +0200
Subject: [PATCH 21/39] ARM: u300: delete all static board data
In-Reply-To: <1369991954-17406-22-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
 <1369991954-17406-22-git-send-email-linus.walleij@stericsson.com>
Message-ID: <6751591.S13Ph9lFnY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 May 2013 11:18:56 Linus Walleij wrote:
>  /* These are mostly to get the right device names for the clock lookups */
>  static struct of_dev_auxdata u300_auxdata_lookup[] __initdata = {
>         OF_DEV_AUXDATA("stericsson,pinctrl-u300", U300_SYSCON_BASE,
> @@ -736,17 +204,17 @@ static struct of_dev_auxdata u300_auxdata_lookup[] __initdata = {
>         OF_DEV_AUXDATA("stericsson,fsmc-nand", U300_NAND_IF_PHYS_BASE,
>                 "fsmc-nand", NULL),
>         OF_DEV_AUXDATA("arm,primecell", U300_UART0_BASE,
> -               "uart0", &uart0_plat_data),
> +               "uart0", NULL),
>         OF_DEV_AUXDATA("arm,primecell", U300_UART1_BASE,
> -               "uart1", &uart1_plat_data),
> +               "uart1", NULL),
>         OF_DEV_AUXDATA("arm,primecell", U300_SPI_BASE,
> -               "pl022", &spi_plat_data),
> +               "pl022", NULL),
>         OF_DEV_AUXDATA("st,ddci2c", U300_I2C0_BASE,
>                 "stu300.0", NULL),
>         OF_DEV_AUXDATA("st,ddci2c", U300_I2C1_BASE,
>                 "stu300.1", NULL),
>         OF_DEV_AUXDATA("arm,primecell", U300_MMCSD_BASE,
> -               "mmci", &mmcsd_platform_data),
> +               "mmci", NULL),
>         { /* sentinel */ },
>  };

I did not see any patch removing the auxdata list in the end.
Do you still need it after the clocks are moved over to DT
probing?

	Arnd
