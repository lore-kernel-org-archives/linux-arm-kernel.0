From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Fri, 16 Feb 2018 20:19:23 +0100
Subject: [PATCH 1/6] nand: davinci: rename the platform driver
In-Reply-To: <20180216164712.25898-2-brgl@bgdev.pl>
References: <20180216164712.25898-1-brgl@bgdev.pl>
 <20180216164712.25898-2-brgl@bgdev.pl>
Message-ID: <20180216201923.16bfca7f@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Feb 2018 17:47:07 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Commit d8e22fb4ccac ("ARM: da850: add the nand dev_id to the clock
> lookup table") broke the nand support in board file mode for
> da850-based boards. Instead of reverting it and breaking the DT users
> in the process (due to clock lookup), rename the driver to match the
> clock table before renaming the users.
> 
> Fixes: d8e22fb4ccac ("ARM: da850: add the nand dev_id to the clock lookup table")
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/mtd/nand/davinci_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
> index ccc8c43abcff..4fb143bf1872 100644
> --- a/drivers/mtd/nand/davinci_nand.c
> +++ b/drivers/mtd/nand/davinci_nand.c
> @@ -865,7 +865,7 @@ static struct platform_driver nand_davinci_driver = {
>  	.probe		= nand_davinci_probe,
>  	.remove		= nand_davinci_remove,
>  	.driver		= {
> -		.name	= "davinci_nand",
> +		.name	= "davinci-nand",

Another side-effect of this change you should be aware of: by doing
that you also break all users that were defining partitions through the
cmdline using mtdparts=davinci_nand.0:<part-layout>.

Not sure this is a good idea ;-).

>  		.of_match_table = of_match_ptr(davinci_nand_of_match),
>  	},
>  };



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
