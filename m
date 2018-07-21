From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 21 Jul 2018 19:53:14 +0200
Subject: [PATCH v4 23/35] mtd: rawnand: txx9ndfmc: rename nand
 controller internal structure
In-Reply-To: <20180720151527.16038-24-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-24-miquel.raynal@bootlin.com>
Message-ID: <20180721195314.527b12b8@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2018 17:15:15 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> As already done in the core, calling a struct nand_controller
> 'hw_control' is misleading. Use the same name as in nand_base.c:
> 'controller'.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/txx9ndfmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
> index 8f5bbbac4612..9019022774f7 100644
> --- a/drivers/mtd/nand/raw/txx9ndfmc.c
> +++ b/drivers/mtd/nand/raw/txx9ndfmc.c
> @@ -73,7 +73,7 @@ struct txx9ndfmc_drvdata {
>  	void __iomem *base;
>  	unsigned char hold;	/* in gbusclock */
>  	unsigned char spw;	/* in gbusclock */
> -	struct nand_controller hw_control;
> +	struct nand_controller controller;
>  };
>  
>  static struct platform_device *mtd_to_platdev(struct mtd_info *mtd)
> @@ -303,7 +303,7 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
>  	dev_info(&dev->dev, "CLK:%ldMHz HOLD:%d SPW:%d\n",
>  		 (gbusclk + 500000) / 1000000, hold, spw);
>  
> -	nand_controller_init(&drvdata->hw_control);
> +	nand_controller_init(&drvdata->controller);
>  
>  	platform_set_drvdata(dev, drvdata);
>  	txx9ndfmc_initialize(dev);
> @@ -337,7 +337,7 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
>  		chip->ecc.bytes = 3;
>  		chip->ecc.strength = 1;
>  		chip->chip_delay = 100;
> -		chip->controller = &drvdata->hw_control;
> +		chip->controller = &drvdata->controller;
>  
>  		nand_set_controller_data(chip, txx9_priv);
>  		txx9_priv->dev = dev;
