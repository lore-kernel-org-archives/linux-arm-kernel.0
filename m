From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 15 Oct 2012 15:24:15 +0200
Subject: [PATCH 1/1] MTD: atmel_nand: use devm_xxx gpio kzalloc, gpio
 and ioremap
In-Reply-To: <507BE8C8.8040901@atmel.com>
References: <1350129982-12106-1-git-send-email-plagnioj@jcrosoft.com>
 <507BE8C8.8040901@atmel.com>
Message-ID: <20121015132415.GV12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >  		goto err_nand_ioremap;
> >  	}
> >+	host->io_phys = (dma_addr_t)mem->start;
> >  	mtd = &host->mtd;
> >  	nand_chip = &host->nand_chip;
> >@@ -1401,7 +1380,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
> >  	if (pdev->dev.of_node) {
> >  		res = atmel_of_init_port(host, pdev->dev.of_node);
> >  		if (res)
> >-			goto err_ecc_ioremap;
> >+			goto err_nand_ioremap;
> >  	} else {
> >  		memcpy(&host->board, pdev->dev.platform_data,
> >  		       sizeof(struct atmel_nand_data));
> >@@ -1420,44 +1399,42 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
> >  	if (IS_ERR(pinctrl)) {
> >  		dev_err(host->dev, "Failed to request pinctrl\n");
> >  		res = PTR_ERR(pinctrl);
> 
> I cannot apply the patch in latest l2-mtd git tree since above line
> of code doesn't committed.
> Seems that code is pinctrl related. Am I missing some patches?

this is base on linux next

and yes with pinctrl

Best Regards,
J.
