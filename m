From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jun 2012 21:10:30 +0000
Subject: [PATCH 5/9] ARM: kirkwood: use devicetree for orion-spi
In-Reply-To: <1339324322-29388-6-git-send-email-andrew@lunn.ch>
References: <1339324322-29388-6-git-send-email-andrew@lunn.ch>
Message-ID: <201206132110.31011.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 10 June 2012, Andrew Lunn wrote:
> @@ -26,6 +26,11 @@ static struct of_device_id kirkwood_dt_match_table[] __initdata = {
>         { }
>  };
>  
> +struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
> +       OF_DEV_AUXDATA("marvell,orion-spi", 0xf1010600, "orion_spi.0", NULL),
> +       {},
> +};
> +
>  static void __init kirkwood_dt_init(void)
>  {

How about instead adding the clkdev for "f1010600.spi" so you don't need the auxdata?

	Arnd
