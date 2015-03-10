From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Mar 2015 10:05:59 +0100
Subject: [PATCH 1/5] soc: mediatek: Add SMI driver
In-Reply-To: <1425968824.4871.146.camel@mtksdaap41>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <2583132.xxsZocsQta@wuerfel> <1425968824.4871.146.camel@mtksdaap41>
Message-ID: <2220384.lLJEdfpchj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 March 2015 14:27:04 Yingjoe Chen wrote:
> On Mon, 2015-03-09 at 22:56 +0100, Arnd Bergmann wrote:
> > On Monday 09 March 2015 11:26:52 Yingjoe Chen wrote:
> > > On Fri, 2015-03-06 at 18:48 +0800, yong.wu at mediatek.com wrote:
> > > > From: Yong Wu <yong.wu@mediatek.com>
> > > > 
> > > >     This patch add SMI(Smart Multimedia Interface) driver. This driver is
> > > > responsible to enable/disable iommu and control the clocks of each
> > > > local arbiter.
> > > > 
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > ---
> > > >  drivers/soc/mediatek/Kconfig      |   7 ++
> > > >  drivers/soc/mediatek/Makefile     |   1 +
> > > >  drivers/soc/mediatek/mt8173-smi.c | 143 ++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/mtk-smi.h           |  40 +++++++++++
> > > >  4 files changed, 191 insertions(+)
> > > >  create mode 100644 drivers/soc/mediatek/mt8173-smi.c
> > > >  create mode 100644 include/linux/mtk-smi.h
> > > > 
> > > 
> > > Hi Arnd, Matthias,
> > > 
> > > For the SMI driver, we can't find a better place, so we put it in
> > > drivers/soc/mediatek now. Please let us know if you have any suggestion
> > > or concern. Thanks
> > 
> > From what I understand from your description, I think it would better
> > fit in drivers/iommu. Another option is drivers/memory, which I think
> > is where the respective Tegra driver ended up.
> 
> Hi Arnd,
> 
> The description above only describe what is implemented now. Besides
> that, SMI HW also does:
> 
> - Prioritize/arbitrate memory requests between different ports & larbs.
> - Bandwidth limiter
> - Performance monitor
> 
> I think drivers/memory make more sense. I can't find info about
> drivers/memory in MAINTAINERS. Can this go through ARM SoC tree if we
> put SMI driver there?
> 

Yes, that works for me. I'd like to see a review from Thierry Reding
though, since he wrote the Tegra driver that is used for very similar
hardware, and I want to make sure you two are on the same page with
the internal APIs.

	Arnd
