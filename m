From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 31 Mar 2015 18:41:19 +0300
Subject: [PATCH 2/2] phy: driver for Conexant Digicolor internal USB PHY
In-Reply-To: <551ABCBE.3030005@ti.com>
References: <6284a7672647d46100281959552f9787f98bb552.1427430989.git.baruch@tkos.co.il>
 <4a9ceb0a240d49dd6a68d50c78f85d310d4b932f.1427430989.git.baruch@tkos.co.il>
 <201503281633.02801.marex@denx.de>
 <20150331113448.GN12479@tarshish> <551ABCBE.3030005@ti.com>
Message-ID: <20150331154119.GO12479@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On Tue, Mar 31, 2015 at 08:56:54PM +0530, Kishon Vijay Abraham I wrote:
> On Tuesday 31 March 2015 05:04 PM, Baruch Siach wrote:
> >On Sat, Mar 28, 2015 at 04:33:02PM +0100, Marek Vasut wrote:
> >>On Friday, March 27, 2015 at 05:36:29 AM, Baruch Siach wrote:
> >>>Add a driver for the USB PHY on the Conexant CX92755 SoC, from the
> >>>Digicolor series of SoCs. The PHY is connected to the on-chip chipidea
> >>>usb2 host.
> >>>
> >>>The hardware is somewhat similar to the phy-mxs-usb.c usb_phy, but it is
> >>>different enough to merit its own driver. Also, this driver uses the
> >>>generic phy infrastructure.
> >>
> >>the register set looks very similar to MXS one indeed. How is it different
> >>please ?
> >
> >Almost of the bits that are defined in the MXS USBPHY_CTRL register are not
> >defined in the Digicolor one. Some have different meaning, and some are
> >reserved. OTOH, the Digicolor USBPHY_CTRL register uses all bits in the 1-13
> >range. Also, the Digicolor phy does not have anatop registers.
> 
> I think we should try adding support for this in the same driver.

The only code that can actually be shared between the driver is the two lines 
usb_phy .on_connect callback routine. The init sequence that takes most of the 
digicolor driver is totally different. Using a single driver for both PHYs 
does not make much sense, IMHO.

Besides, phy-mxs-usb.c uses the deprecated usb_phy framework. So we first need 
to port this driver to the generic phy framework.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
