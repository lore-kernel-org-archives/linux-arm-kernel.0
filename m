From: andi.shyti@samsung.com (Andi Shyti)
Date: Thu, 07 Jul 2016 18:58:41 +0900
Subject: [PATCH] spi: s3c64xx: do not disable the clock while configuring
 the spi
In-Reply-To: <1467876237-12183-1-git-send-email-andi.shyti@samsung.com>
References: <CGME20160707072419epcas1p3ba881fb9b3270eb8cde87380aea7bcf9@epcas1p3.samsung.com>
 <1467876237-12183-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <20160707095840.GH23620@samsunx.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>  	if (sdd->port_conf->clk_from_cmu) {
> -		/* Configure Clock */
> -		/* There is half-multiplier before the SPI */
>  		clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);

sorry, I will re-send it because I should not remove the comments
above.... in the future someone might wonder why it's multiplied
by 2.

That's called auto review and auto-nack :)

Andi

> -		/* Enable Clock */
> -		clk_prepare_enable(sdd->src_clk);
>  	} else {
>  		/* Configure Clock */
>  		val = readl(regs + S3C64XX_SPI_CLK_CFG);
> -- 
> 2.8.1
> 
