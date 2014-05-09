From: pavel@denx.de (Pavel Machek)
Date: Fri, 9 May 2014 11:43:30 +0200
Subject: [PATCH 05/17] pci: host: pcie-dra7xx: add support for
 pcie-dra7xx controller
In-Reply-To: <201405061544.28738.marex@denx.de>
References: <1399383244-14556-1-git-send-email-kishon@ti.com>
 <1399383244-14556-6-git-send-email-kishon@ti.com>
 <201405061544.28738.marex@denx.de>
Message-ID: <20140509094330.GB4877@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +	writel(value, base + offset);
> > +}
> > +
> > +static int dra7xx_pcie_link_up(struct pcie_port *pp)
> > +{
> > +	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
> > +	u32 reg = dra7xx_pcie_readl(dra7xx->base, PCIECTRL_DRA7XX_CONF_PHY_CS);
> > +
> > +	if (reg & LINK_UP)
> > +		return true;
> > +	return false;
> 
> return reg & LINK_UP;

Function int returning true. I'd change the prototype and would
return !!(reg & ...);

									Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
