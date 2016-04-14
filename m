From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Thu, 14 Apr 2016 09:58:49 +0800
Subject: [PATCH v2 2/2] phy: phy-mt65xx-usb3: add support for mt2701
 platform
In-Reply-To: <570E4A29.3030103@ti.com>
References: <1460360490-18606-1-git-send-email-chunfeng.yun@mediatek.com>
 <1460360490-18606-2-git-send-email-chunfeng.yun@mediatek.com>
 <570E4A29.3030103@ti.com>
Message-ID: <1460599129.5156.12.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2016-04-13 at 19:01 +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 11 April 2016 01:11 PM, Chunfeng Yun wrote:
> > A new compatible string, "mediatek,mt2701-u3phy", is added.
> > 
> > Some register settings to avoid RX sensitivity level degradation
> > which may arise on mt8173 platform are separated from other
> > platforms.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  drivers/phy/Kconfig           |    5 ++-
> >  drivers/phy/phy-mt65xx-usb3.c |   77 ++++++++++++++++++++++++++++-------------
> >  2 files changed, 54 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> > index 26566db..3037f28 100644
> > --- a/drivers/phy/Kconfig
> > +++ b/drivers/phy/Kconfig
> > @@ -218,9 +218,8 @@ config PHY_MT65XX_USB3
> >  	depends on ARCH_MEDIATEK && OF
> >  	select GENERIC_PHY
> >  	help
> > -	  Say 'Y' here to add support for Mediatek USB3.0 PHY driver
> > -	  for mt65xx SoCs. it supports two usb2.0 ports and
> > -	  one usb3.0 port.
> > +	  Say 'Y' here to add support for Mediatek USB3.0 PHY driver,
> > +	  it supports multiple usb2.0 and usb3.0 ports.
> 
> Do you mean this PHY driver support both USB2 and USB3? Then it's not really a
> USB3 PHY driver right?
> 
Sorry for my unclear description.

It supports USB3 PHY, and each USB3 PHY in fact includes a USB2 PHY and
a SuperSpeed PHY.

Thanks a lot

> Thanks
> Kishon
