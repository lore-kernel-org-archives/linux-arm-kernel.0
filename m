From: b-liu@ti.com (Bin Liu)
Date: Fri, 1 Apr 2016 11:19:31 -0500
Subject: [PATCH v2 06/11] phy: da8xx-usb: new driver for DA8XX SoC USB PHY
In-Reply-To: <56FE9B8F.7050605@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-7-git-send-email-david@lechnology.com>
 <56FE74AC.6080303@ti.com> <20160401144510.GA6264@uda0271908>
 <56FE9B8F.7050605@lechnology.com>
Message-ID: <20160401161931.GC6264@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 01, 2016 at 11:02:23AM -0500, David Lechner wrote:
> On 04/01/2016 09:45 AM, Bin Liu wrote:
> >>>+EXPORT_SYMBOL_GPL(da8xx_usb20_phy_set_mode);
> >>
> >>Don't prefer export symbols from PHY driver. That'll create unnecessary
> >>dependencies between the controller and the PHY.
> >
> >Agreed.
> >
> >>
> >>I think it'll be better to create a new attribute and use it?
> >
> >Another simpler option is to not support _set_mode() for DA8xx, and the
> >phy driver set the otgmode bit in probe() based on dr_mode of the
> >controller.
> >
> >Regards,
> >-Bin.
> >
> 
> This certainly works for my particular use case, however, Sergei
> Shtylyov, who wrote the da8xx musb glue layer originally, seemed to
> recall in his review of the patch series that this really is
> necessary for OTG mode to work properly.

I don't know much about the usb module on DA8xx, but it seems to me that
_set_mode() has nothing to do with OTG mode. musb_core only calls
_set_mode() in two places - 1) sysfs: musb_mode_store(), 2) init:
musb_init_controller(). None of them should be related to OTG mode.

Regards,
-Bin.
