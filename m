From: marex@denx.de (Marek Vasut)
Date: Thu, 5 Jul 2012 01:20:07 +0200
Subject: [PATCH 8/8] mmc: spi: Add DMA support into SPI driver
In-Reply-To: <201207042340.55301.marex@denx.de>
References: <1340958180-2291-1-git-send-email-marex@denx.de>
 <CAOMZO5AN852f3Awv0UG+ApsgMC-x5ByQrLkUC5SkOnty5T0EMA@mail.gmail.com>
 <201207042340.55301.marex@denx.de>
Message-ID: <201207050120.08071.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marek Vasut,

> Dear Fabio Estevam,
> 
> > Hi Marek,
> > 
> > On 6/29/12, Marek Vasut <marex@denx.de> wrote:
> > >  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > 
> > > -	if (!iores)
> > > +	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> > > +	irq_err = platform_get_irq(pdev, 0);
> > > +	irq_dma = platform_get_irq(pdev, 1);
> > > +	if (!iores || irq_err < 0 || irq_dma < 0)
> > 
> > Shouldn't you check for dmares < 0 here too?
> 
> Yes. What about the rest of the patches? Are they applicable?

(Lemme answer to myself)

The DT documentation is missing. Ok, I'll send it in the next round. So any 
other comments please? :)

> Best regards,
> Marek Vasut

Best regards,
Marek Vasut
