From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 23 Nov 2013 19:15:29 +0100
Subject: [PATCH 1/3] mtd: nand: davinci: reuse driver for Keystone arch
In-Reply-To: <1384964699-15134-2-git-send-email-ivan.khoronzhuk@ti.com>
References: <1384964699-15134-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1384964699-15134-2-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <201311231915.29643.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 November 2013, Ivan Khoronzhuk wrote:
> --- a/drivers/mtd/nand/davinci_nand.c
> +++ b/drivers/mtd/nand/davinci_nand.c
> @@ -523,6 +523,7 @@ static struct nand_ecclayout hwecc4_2048 __initconst = {
>  #if defined(CONFIG_OF)
>  static const struct of_device_id davinci_nand_of_match[] = {
>         {.compatible = "ti,davinci-nand", },
> +       {.compatible = "ti,keystone-nand", },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, davinci_nand_of_match);

Same comment as for the watchdog driver: when the devices are actually compatible,
the driver does not need to know the new string, the preferred method is to
set both strings from the .dts file.

	Arnd
