From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 10 Mar 2015 10:24:03 +0100
Subject: [PATCH 1/5] soc: mediatek: Add SMI driver
In-Reply-To: <2583132.xxsZocsQta@wuerfel>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <1425638900-24989-2-git-send-email-yong.wu@mediatek.com>
 <1425871612.4871.10.camel@mtksdaap41> <2583132.xxsZocsQta@wuerfel>
Message-ID: <1425979443.6226.4.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Am Montag, den 09.03.2015, 22:56 +0100 schrieb Arnd Bergmann:
> On Monday 09 March 2015 11:26:52 Yingjoe Chen wrote:
> > On Fri, 2015-03-06 at 18:48 +0800, yong.wu at mediatek.com wrote:
> > > From: Yong Wu <yong.wu@mediatek.com>
> > > 
> > >     This patch add SMI(Smart Multimedia Interface) driver. This driver is
> > > responsible to enable/disable iommu and control the clocks of each
> > > local arbiter.
> > > 
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  drivers/soc/mediatek/Kconfig      |   7 ++
> > >  drivers/soc/mediatek/Makefile     |   1 +
> > >  drivers/soc/mediatek/mt8173-smi.c | 143 ++++++++++++++++++++++++++++++++++++++
> > >  include/linux/mtk-smi.h           |  40 +++++++++++
> > >  4 files changed, 191 insertions(+)
> > >  create mode 100644 drivers/soc/mediatek/mt8173-smi.c
> > >  create mode 100644 include/linux/mtk-smi.h
> > > 
> > 
> > Hi Arnd, Matthias,
> > 
> > For the SMI driver, we can't find a better place, so we put it in
> > drivers/soc/mediatek now. Please let us know if you have any suggestion
> > or concern. Thanks
> 
> From what I understand from your description, I think it would better
> fit in drivers/iommu. Another option is drivers/memory, which I think
> is where the respective Tegra driver ended up.
> 
Note that this is not the IOMMU driver. M4U is the IOMMU unit. The SMI
unit is more of a bridge control for the internal buses where you can
control various properties for the masters on the bus.

One notable property (and why this driver is part of the IOMMU series)
is the control weather a master should go through the M4U unit for
translation or bypass it and talk directly to external memory
controller.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
