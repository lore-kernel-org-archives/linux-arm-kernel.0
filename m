From: linuxzsc@gmail.com (Richard Zhao)
Date: Tue, 22 May 2012 23:28:35 +0800
Subject: [PATCH v2 05/12] usb: chipidea: add imx driver binding
In-Reply-To: <87bolgbjnr.fsf@ashishki-desk.ger.corp.intel.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-6-git-send-email-richard.zhao@freescale.com>
 <87bolgbjnr.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20120522152833.GC2380@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 01:21:44PM +0300, Alexander Shishkin wrote:
> Richard Zhao <richard.zhao@freescale.com> writes:
> 
> > +#include "ci.h"
> > +
> > +#define PORT0_STATUS	0x184
> 
> This doesn't seem to be used anywhere.
> 
> [snip]
> > +	ci13xxx_imx_udc_driver.phy = data->phy;
> 
> See my comment to the other patch about phy pointer being a per-device
> thing rather then per-platform driver. Now, (at the risk of being
> flamed) I think it could work if you allocated the
> ci13xxx_imx_udc_driver dynamically in every probe, but that's not what
> you want to do for the actual platform data. 
At least for imx, most platfrom data memory is duplicated when add
device. arch/arm/plat-mxc/devices/
> So, I suggest we come up
> with a better way of passing phy to the driver. I also think that it's
> really about time we renamed "struct ci13xxx_udc_driver" to something
> that emphasizes the "platform" in it. What do you think?
struct ci13xxx_plat_data ?

Thanks
Richard
> 
> Regards,
> --
> Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
