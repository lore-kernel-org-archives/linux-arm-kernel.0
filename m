From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 21 Jan 2016 13:50:44 +0800
Subject: [PATCH v3 1/6] clk: mediatek: Refine the makefile to support
 multiple clock drivers
In-Reply-To: <1453344325.28078.9.camel@mtksdaap41>
References: <1452587470-61506-1-git-send-email-jamesjj.liao@mediatek.com>
 <1452587470-61506-2-git-send-email-jamesjj.liao@mediatek.com>
 <1453343300.28078.6.camel@mtksdaap41> <1453344325.28078.9.camel@mtksdaap41>
Message-ID: <1453355444.5384.43.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yingjoe,

On Thu, 2016-01-21 at 10:45 +0800, Yingjoe Chen wrote:
> On Thu, 2016-01-21 at 10:28 +0800, Yingjoe Chen wrote:
> > On Tue, 2016-01-12 at 16:31 +0800, James Liao wrote:
> > > Add a Kconfig to define clock configuration for each SoC, and
> > > modify the Makefile to build drivers that only selected in config.
> > > 
> > > Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
> > > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > > ---
> > >  drivers/clk/Kconfig           |  1 +
> > >  drivers/clk/mediatek/Kconfig  | 23 +++++++++++++++++++++++
> > >  drivers/clk/mediatek/Makefile |  6 +++---
> > >  3 files changed, 27 insertions(+), 3 deletions(-)
> > >  create mode 100644 drivers/clk/mediatek/Kconfig
> > > 
> > > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > > index c3e3a02..b7a37dc 100644
> > > --- a/drivers/clk/Kconfig
> > > +++ b/drivers/clk/Kconfig
> > > @@ -198,3 +198,4 @@ source "drivers/clk/mvebu/Kconfig"
> > >  
> > >  source "drivers/clk/samsung/Kconfig"
> > >  source "drivers/clk/tegra/Kconfig"
> > > +source "drivers/clk/mediatek/Kconfig"
> > 
> > 
> > Hi James,
> > 
> > drivers/clk/mediatek/Kconfig add user selectable options, menuconfig
> > will list them outside of "Common Clock Framework" sub-menu if you
> > source the file here. Kconfig for samsung & tegra doesn't have any, so
> > it is OK for them to stay here.
> > 
> > Please move it inside the menu, also it seems the source lines are
> > sorted now, so let's keep them sorted.
> 
> 
> After looking at drivers/clk/Kconfig history, it seems we have similar
> issue before. I think we should move all sources under clk menu to
> prevent this from happening.

I may provide a separated patch to move other Kconfig into menu section.


Best regards,

James
