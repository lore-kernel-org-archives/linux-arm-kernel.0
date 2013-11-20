From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Nov 2013 13:06:56 +0100
Subject: [PATCH v2 3/4] ata: add APM X-Gene SoC 6.0Gbps SATA PHY driver
In-Reply-To: <20131120113704.GT5914@e106331-lin.cambridge.arm.com>
References: <1384905197-3566-1-git-send-email-lho@apm.com>
 <1384905197-3566-4-git-send-email-lho@apm.com>
 <20131120113704.GT5914@e106331-lin.cambridge.arm.com>
Message-ID: <40736575.jvgUcOHqUx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 November 2013 11:37:05 Mark Rutland wrote:
> > +static void phy_rd(void *addr, u32 *val)
> > +{
> > +       *val = readl(addr);
> > +#if defined(XGENE_DBG1_CSR)
> > +       pr_debug("SATAPHY CSR RD: 0x%p value: 0x%08x\n", addr, *val);
> 
> Can you not use dev_dbg here as you do elsehere?
> 
> Either that or make your own debug print function, with the ifdefs
> hidden in its definition.
> 

pr_debug() is already conditional on #ifdef DEBUG, the extra #if
can just get removed here.

	Arnd
