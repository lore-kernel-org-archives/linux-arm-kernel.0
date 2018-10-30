From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 30 Oct 2018 12:56:38 +0100
Subject: [PATCH 1/2] net:stmmac: dwmac-mediatek: add support for mt2712
In-Reply-To: <1540883812.26982.15.camel@mhfsdcap03>
References: <1540782294-27721-1-git-send-email-biao.huang@mediatek.com>
 <1540782294-27721-2-git-send-email-biao.huang@mediatek.com>
 <20181029100828.GA19103@Red> <1540883812.26982.15.camel@mhfsdcap03>
Message-ID: <20181030115638.GB27873@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +	plat_dat->interface = priv_plat->phy_mode;
> > > +	/* clk_csr_i = 250-300MHz & MDC = clk_csr_i/124 */
> > > +	plat_dat->clk_csr = 5;
> > > +	plat_dat->has_gmac4 = 1;
> > > +	plat_dat->has_gmac = 0;
> > > +	plat_dat->pmt = 0;
> > > +	plat_dat->maxmtu = 1500;
> > 
> > ETH_DATA_LEN ?
> how about getting maxmtu from device tree rather than assignment here?

Does it vary between devices? I expect it is a constant, determined by
the DMA hardware design. So no need to make it configurabale.

    Andrew
