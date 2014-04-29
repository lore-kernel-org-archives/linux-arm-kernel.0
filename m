From: b32955@freescale.com (Huang Shijie)
Date: Tue, 29 Apr 2014 14:05:04 +0800
Subject: [PATCH v2 02/10] mtd: spi-nor: add a new field for spi_nor{}
In-Reply-To: <201404290854.25116.marex@denx.de>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com>
 <201404282223.26174.marex@denx.de> <20140429051832.GC21064@localhost>
 <201404290854.25116.marex@denx.de>
Message-ID: <20140429060502.GA14227@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 08:54:24AM +0200, Marek Vasut wrote:
> On Tuesday, April 29, 2014 at 07:18:34 AM, Huang Shijie wrote:
> > For the m25p80.c, @dev stands for a child node for the SPI master,
> > and it points to a spi_device{}. Yes, in this case, the dev->of_node is
> > NULL.
> > 
> > But for the fsl_quadspi or other SPI NOR drivers, the @dev stands for the
> > controller itself, the @dev->of_node is a list of the child nodes, so we
> > can _NOT_ know which child node we are working at now.
> 
> Huh ? The dev is being recycled for two different kind of things ?
yes.

for the SPI bus, the of_register_spi_devices() will allocate a spi_device{}
for each child node for the SPI NOR flash. So in the m25p80.c, the @dev points
to a spi_device{}.

For the simplicity,  we do not allocate any *_device{} for the child
node in the SPI NOR flash driver, such as in the fsl-quadspi.c.

thanks
Huang Shijie
