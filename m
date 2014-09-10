From: b38343@freescale.com (Robin Gong)
Date: Wed, 10 Sep 2014 16:28:55 +0800
Subject: [PATCH v5] spi: spi-imx: add DMA support
In-Reply-To: <5412055.BAOgFikuh9@wuerfel>
References: <1410312604-31949-1-git-send-email-b38343@freescale.com>
 <5412055.BAOgFikuh9@wuerfel>
Message-ID: <20140910082853.GA29906@Robin-OptiPlex-780>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 10:17:14AM +0200, Arnd Bergmann wrote:
> On Wednesday 10 September 2014 09:30:04 Robin Gong wrote:
> > Enable DMA support on i.mx6. The read speed can increase from 600KB/s
> > to 1.2MB/s on i.mx6q. You can disable or enable dma function in dts.
> > If not set "dma-names" in dts, spi will use PIO mode. This patch only
> > validate on i.mx6, not i.mx5, but encourage ones to apply this patch
> > on i.mx5 since they share the same IP.
> > 
> > Note:
> >   Sometime, there is a weid data in rxfifo after one full tx/rx
> > transfer finish by DMA on i.mx6dl, so we disable dma functhion on
> > i.mx6dl.
> > 
> > Signed-off-by: Frank Li <Frank.Li@freescale.com>
> > Signed-off-by: Robin Gong <b38343@freescale.com>
> > 
> > 
> 
> The patch looks good to me, but you need to also update the
> Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt file to
> document the additional optional properties.
> 
> 	Arnd
Thanks for your reminding, I'll add it in the v6.
