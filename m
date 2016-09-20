From: sergio.prado@e-labworks.com (Sergio Prado)
Date: Mon, 19 Sep 2016 23:31:49 -0300
Subject: [PATCH] mtd: s3c2410: add device tree support
In-Reply-To: <f8907616-0d6b-37ef-1419-f6aedf3ddbdc@samsung.com>
References: <CGME20160917152404eucas1p2ca0ebfe59dd762f5cdd611a9dd3cd1a5@eucas1p2.samsung.com>
 <1474125760-28168-1-git-send-email-sergio.prado@e-labworks.com>
 <f8907616-0d6b-37ef-1419-f6aedf3ddbdc@samsung.com>
Message-ID: <20160920023149.GC11294@n1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 12:44:07PM +0200, Sylwester Nawrocki wrote:
> On 09/17/2016 05:22 PM, Sergio Prado wrote:
> > +static int s3c24xx_nand_probe_dt(struct platform_device *pdev)
> > +{
> > +	const struct s3c24XX_nand_devtype_data *devtype_data;
> > +	struct s3c2410_platform_nand *pdata;
> > +	struct s3c2410_nand_info *info = platform_get_drvdata(pdev);
> > +	struct device_node *np = pdev->dev.of_node, *child;
> > +	const struct of_device_id *of_id;
> > +	struct s3c2410_nand_set *sets;
> > +
> > +	of_id = of_match_device(s3c24xx_nand_dt_ids, &pdev->dev);
> > +	if (!of_id)
> > +		return 1;
> > +
> > +	devtype_data = of_id->data;
> 
> You could make it a bit simpler with of_device_get_match_data().

I wasn't aware of this interface. I'll use it. Thanks!

> 
> --
> Thanks,
> Sylwester

-- 
Sergio Prado
Embedded Labworks
Office: +55 11 2628-3461
Mobile: +55 11 97123-3420
