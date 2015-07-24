From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Fri, 24 Jul 2015 17:16:23 +0000
Subject: [PATCH 1/1] Serial: imx: add dev_pm_ops to support suspend to
 ram/disk
In-Reply-To: <20150724003722.GA14027@kroah.com>
References: <1437165018-56026-1-git-send-email-shenwei.wang@freescale.com>
 <20150724003722.GA14027@kroah.com>
Message-ID: <BL2PR03MB370BD6DAA817B559802A8BF83810@BL2PR03MB370.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Greg KH [mailto:gregkh at linuxfoundation.org]
> Sent: 2015?7?23? 19:37
> To: Wang Shenwei-B38339
> Cc: linux-serial at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/1] Serial: imx: add dev_pm_ops to support suspend to
> ram/disk
> > +	sport->saved_reg[4] = readl(sport->port.membase + UFCR);
> > +	sport->saved_reg[5] = readl(sport->port.membase + UESC);
> > +	sport->saved_reg[6] = readl(sport->port.membase + UTIM);
> > +	sport->saved_reg[7] = readl(sport->port.membase + UBIR);
> > +	sport->saved_reg[8] = readl(sport->port.membase + UBMR);
> > +	sport->saved_reg[9] = readl(sport->port.membase + IMX21_UTS);
> > +	clk_disable(sport->clk_ipg);
> > +
> > +	pr_debug("0x%p (%d)\r\n", sport->port.membase, sport->port.line);
> 
> You have a struct device, please use dev_dbg() instead.

Adopted in PATCH v2.

> 
> > +
> > +	return 0;
> > +}
> > +
> > +	writel(sport->saved_reg[2], sport->port.membase + UCR3);
> > +	writel(sport->saved_reg[3], sport->port.membase + UCR4);
> > +	clk_disable(sport->clk_ipg);
> > +
> > +	pr_debug("0x%p (%d)\r\n", sport->port.membase, sport->port.line);
> 
> Same here, please use dev_dbg()

Adopted in PATCH v2.

Thanks,
Shenwei
