From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 21 Jul 2018 18:57:37 +0200
Subject: [PATCH v4 13/35] mtd: rawnand: marvell: convert driver to
 nand_scan()
In-Reply-To: <20180720151527.16038-14-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-14-miquel.raynal@bootlin.com>
Message-ID: <20180721185537.01f01362@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2018 17:15:05 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

>  
> -	ret = nand_scan_tail(mtd);
> +	chip->controller->ops = &marvell_nand_controller_ops;

Assigning ->ops to &marvell_nand_controller_ops should be done only
once in the probe function (here [1]). With that fixed, you can add

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> +	ret = nand_scan(mtd, marvell_nand->nsels);
>  	if (ret) {
> -		dev_err(dev, "nand_scan_tail failed: %d\n", ret);
> +		dev_err(dev, "could not scan the nand chip\n");
>  		return ret;
>  	}
>  
