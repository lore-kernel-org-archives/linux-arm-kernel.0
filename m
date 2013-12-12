From: mporter@linaro.org (Matt Porter)
Date: Thu, 12 Dec 2013 17:07:26 -0500
Subject: [PATCH v5 3/9] usb: gadget: s3c-hsotg: enable build for other
 platforms
In-Reply-To: <52AA2FE3.3060200@gmail.com>
References: <1386854770-2173-1-git-send-email-mporter@linaro.org>
 <1386854770-2173-4-git-send-email-mporter@linaro.org>
 <52AA2FE3.3060200@gmail.com>
Message-ID: <20131212220726.GA4205@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 03:51:31PM -0600, Dinh Nguyen wrote:
> Hi Matt,
> 
> On 12/12/13 7:26 AM, Matt Porter wrote:
> > Remove unused Samsung-specific machine include and Kconfig
> > dependency on S3C.
> >
> > Signed-off-by: Matt Porter <mporter@linaro.org>
> > Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> > Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> > ---
> >  drivers/usb/gadget/Kconfig     | 7 +++----
> >  drivers/usb/gadget/s3c-hsotg.c | 2 --
> >  2 files changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> > index a91e642..970bd1a 100644
> > --- a/drivers/usb/gadget/Kconfig
> > +++ b/drivers/usb/gadget/Kconfig
> > @@ -294,11 +294,10 @@ config USB_PXA27X
> >  	   gadget drivers to also be dynamically linked.
> >  
> >  config USB_S3C_HSOTG
> > -	tristate "S3C HS/OtG USB Device controller"
> > -	depends on S3C_DEV_USB_HSOTG
> > +	tristate "Designware/S3C HS/OtG USB Device controller"
> >  	help
> > -	  The Samsung S3C64XX USB2.0 high-speed gadget controller
> > -	  integrated into the S3C64XX series SoC.
> > +	  The Designware USB2.0 high-speed gadget controller
> > +	  integrated into the S3C64XX and BCM281xx series SoC.
> Thanks for doing this. The SOCFPGA platform is also using this driver.
> So perhaps a
> more generic message here?

Ok, I wasn't aware since I didn't see anybody else try to fix this
driver in mainline. How about this?

	The Designware USB2.0 high-speed gadget controller
	integrated into many SoCS.

If that looks better to you I'll plan to add it in an update. I would
like to see if we can gather a couple acks at this point or if there are
any additional DT comments before sending another update.

-Matt

> >  
> >  config USB_S3C2410
> >  	tristate "S3C2410 USB Device Controller"
> > diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
> > index 33eb690..8ceb5ef 100644
> > --- a/drivers/usb/gadget/s3c-hsotg.c
> > +++ b/drivers/usb/gadget/s3c-hsotg.c
> > @@ -37,8 +37,6 @@
> >  #include <linux/usb/phy.h>
> >  #include <linux/platform_data/s3c-hsotg.h>
> >  
> > -#include <mach/map.h>
> > -
> >  #include "s3c-hsotg.h"
> >  
> >  static const char * const s3c_hsotg_supply_names[] = {
> 
