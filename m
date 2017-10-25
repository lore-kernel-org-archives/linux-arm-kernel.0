From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 25 Oct 2017 16:26:20 +0300
Subject: [PATCH] I2C-S3C2410: Use common error handling code in
 s3c24xx_i2c_probe()
In-Reply-To: <32c82282-ee0a-137f-4913-310b194b60f3@users.sourceforge.net>
References: <32c82282-ee0a-137f-4913-310b194b60f3@users.sourceforge.net>
Message-ID: <20171025132620.l7scp2eachnarpzt@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> @@ -1180,24 +1179,21 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
>  		i2c->irq = ret = platform_get_irq(pdev, 0);
>  		if (ret <= 0) {

Not related to this patch, but the comparison here should be < 0.  Or
otherwise we should set an error code.  The bug was introduced in commit
e0d1ec97853f ("i2c-s3c2410: Change IRQ to be plain integer.").

>  			dev_err(&pdev->dev, "cannot find IRQ\n");
> -			clk_unprepare(i2c->clk);
> -			return ret;

regards,
dan carpenter
