From: yao.yuan@freescale.com (Yao Yuan)
Date: Wed, 26 Mar 2014 05:56:34 +0000
Subject: [PATCH v3 1/2] i2c: add DMA support for freescale i2c driver
In-Reply-To: <201403260442.42970.marex@denx.de>
References: <1394675277-24913-1-git-send-email-yao.yuan@freescale.com>
 <201403230449.51515.marex@denx.de>
 <1e17ce716618472f9a0146c48f20b976@BL2PR03MB338.namprd03.prod.outlook.com>
 <201403260442.42970.marex@denx.de>
Message-ID: <cd88de7e04734400b897c0e2bcf07eab@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 26, 2014 at 11:43:27 AM, Marek Vasut wrote:
> On Wednesday, March 26, 2014 at 04:08:27 AM, Yao Yuan wrote:
> 
> [...]
> 
> > > > +		i2c_imx->use_dma = false;
> > > > +	} else if (i2c_imx_dma_request(i2c_imx, (dma_addr_t)phy_addr))
> {
> > > > +		dev_info(&pdev->dev,
> > > > +				"can't request dma chan, faild use dma.\n");
> > > > +		i2c_imx->use_dma = false;
> > > > +	} else {
> > > > +		i2c_imx->use_dma = true;
> > > > +	}
> > >
> > > Can you not just check if i2c_imx->dma is valid pointer or NULL
> pointer ?
> > > Then you won't need a separate variable, for this purpose ... right ?
> >
> > Sorry and I think what I know is just to check whether it is NULL.
> > Then for the second question, maybe there are some other ways, But I
> > think it is more tidy and easier understanding for using a separate
> > variable, for this purpose.
> 
> You are just wasting space and duplicating data, unless I am wrong.
> 

Well, Do you have a better idea? Although I think it's necessary.


Best regards,
Yuan Yao
