From: balbi@ti.com (Felipe Balbi)
Date: Fri, 28 Sep 2012 15:59:30 +0300
Subject: [PATCH 4/6] usb: dwc3-omap: Add an API to write to dwc mailbox
In-Reply-To: <1348836795-4783-5-git-send-email-kishon@ti.com>
References: <1348836795-4783-1-git-send-email-kishon@ti.com>
 <1348836795-4783-5-git-send-email-kishon@ti.com>
Message-ID: <20120928125929.GM31006@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 28, 2012 at 06:23:13PM +0530, Kishon Vijay Abraham I wrote:
> Add an API in the omap glue layer to write to the mailbox register which
> can be used by comparator driver(twl). To pass the detection of the attached
> device (signified by VBUS, ID) to the dwc3 core, dwc3 core has to write
> to the mailbox regiter.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/usb/dwc3/dwc3-omap.c  |   59 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/usb/dwc3-omap.h |   30 +++++++++++++++++++++
>  2 files changed, 89 insertions(+)
>  create mode 100644 include/linux/usb/dwc3-omap.h
> 
> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> index a1704c6..7ae4d73 100644
> --- a/drivers/usb/dwc3/dwc3-omap.c
> +++ b/drivers/usb/dwc3/dwc3-omap.c
> @@ -43,6 +43,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/dwc3-omap.h>
> +#include <linux/usb/dwc3-omap.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/ioport.h>
> @@ -126,6 +127,8 @@ struct dwc3_omap {
>  	u32			dma_status:1;
>  };
>  
> +struct dwc3_omap		*_omap;
> +
>  static inline u32 dwc3_omap_readl(void __iomem *base, u32 offset)
>  {
>  	return readl(base + offset);
> @@ -136,6 +139,56 @@ static inline void dwc3_omap_writel(void __iomem *base, u32 offset, u32 value)
>  	writel(value, base + offset);
>  }
>  
> +void omap_dwc3_mailbox(enum omap_dwc3_vbus_id_status status)

all other functions are "dwc3_omap_", let's keep it consistent.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120928/f88dff54/attachment.sig>
