From: marex@denx.de (Marek Vasut)
Date: Tue, 29 Apr 2014 08:54:24 +0200
Subject: [PATCH v2 02/10] mtd: spi-nor: add a new field for spi_nor{}
In-Reply-To: <20140429051832.GC21064@localhost>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com>
 <201404282223.26174.marex@denx.de> <20140429051832.GC21064@localhost>
Message-ID: <201404290854.25116.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 29, 2014 at 07:18:34 AM, Huang Shijie wrote:
> On Mon, Apr 28, 2014 at 10:23:26PM +0200, Marek Vasut wrote:
> > On Monday, April 28, 2014 at 05:53:39 AM, Huang Shijie wrote:
> > > We need the SPI NOR child node to store some specific features, such as
> > > the dummy cycles for the DDR Quad read.
> > > 
> > > But now, we only have the @dev field in the spi_nor{}. The @dev may
> > > points to a spi_device{} for m25p80, while it may points to a
> > > platform_deivice{} for the SPI NOR controller, such as fsl_quadspi.c.
> > > 
> > > It is not convenient for us to get come information from the SPI NOR
> > > flash.
> > > 
> > > This patch adds a new field @np to spi_nor{}, it points to the child
> > > node for the SPI NOR flash.
> > > 
> > > Signed-off-by: Huang Shijie <b32955@freescale.com>
> > 
> > Just handle the case where dev->of_node == NULL instead ?
> 
> It is not enough.
> 
> For the m25p80.c, @dev stands for a child node for the SPI master,
> and it points to a spi_device{}. Yes, in this case, the dev->of_node is
> NULL.
> 
> But for the fsl_quadspi or other SPI NOR drivers, the @dev stands for the
> controller itself, the @dev->of_node is a list of the child nodes, so we
> can _NOT_ know which child node we are working at now.

Huh ? The dev is being recycled for two different kind of things ?

> So it's better to add a new field @np for the spi-nor{} which points the
> child node we are working at.

Best regards,
Marek Vasut
