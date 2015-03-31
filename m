From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 31 Mar 2015 14:34:48 +0300
Subject: [PATCH 2/2] phy: driver for Conexant Digicolor internal USB PHY
In-Reply-To: <201503281633.02801.marex@denx.de>
References: <6284a7672647d46100281959552f9787f98bb552.1427430989.git.baruch@tkos.co.il>
 <4a9ceb0a240d49dd6a68d50c78f85d310d4b932f.1427430989.git.baruch@tkos.co.il>
 <201503281633.02801.marex@denx.de>
Message-ID: <20150331113448.GN12479@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Sat, Mar 28, 2015 at 04:33:02PM +0100, Marek Vasut wrote:
> On Friday, March 27, 2015 at 05:36:29 AM, Baruch Siach wrote:
> > Add a driver for the USB PHY on the Conexant CX92755 SoC, from the
> > Digicolor series of SoCs. The PHY is connected to the on-chip chipidea
> > usb2 host.
> > 
> > The hardware is somewhat similar to the phy-mxs-usb.c usb_phy, but it is
> > different enough to merit its own driver. Also, this driver uses the
> > generic phy infrastructure.
> 
> the register set looks very similar to MXS one indeed. How is it different 
> please ?

Almost of the bits that are defined in the MXS USBPHY_CTRL register are not 
defined in the Digicolor one. Some have different meaning, and some are 
reserved. OTOH, the Digicolor USBPHY_CTRL register uses all bits in the 1-13 
range. Also, the Digicolor phy does not have anatop registers.

> The driver looks OK.

Thanks.

BTW, do you know why the phy-mxs-usb driver calls its init from 
postcore_initcall? Is there a special need to register the driver so early?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
