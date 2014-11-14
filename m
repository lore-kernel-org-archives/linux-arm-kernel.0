From: balbi@ti.com (Felipe Balbi)
Date: Fri, 14 Nov 2014 15:08:32 -0600
Subject: [PATCH v7 08/13] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <1415978763-27345-9-git-send-email-antoine.tenart@free-electrons.com>
References: <1415978763-27345-1-git-send-email-antoine.tenart@free-electrons.com>
 <1415978763-27345-9-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20141114210832.GE16388@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 04:25:58PM +0100, Antoine Tenart wrote:
> Add a USB2 ChipIdea driver for ci13xxx, with optional PHY, clock
> and DMA mask, to support USB2 ChipIdea controllers that don't need
> specific functions.
> 
> Tested on the Marvell Berlin SoCs USB controllers.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/usb/chipidea/Makefile       |   1 +
>  drivers/usb/chipidea/ci_hdrc_usb2.c | 117 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 118 insertions(+)
>  create mode 100644 drivers/usb/chipidea/ci_hdrc_usb2.c
> 
> diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
> index 2f099c7df7b5..1fc86a2ca22d 100644
> --- a/drivers/usb/chipidea/Makefile
> +++ b/drivers/usb/chipidea/Makefile
> @@ -10,6 +10,7 @@ ci_hdrc-$(CONFIG_USB_OTG_FSM)		+= otg_fsm.o
>  
>  # Glue/Bridge layers go here
>  
> +obj-$(CONFIG_USB_CHIPIDEA)	+= ci_hdrc_usb2.o

usb2 is too generic, you should call it ci_hdcr_marvell, or something
like that.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/1643ad17/attachment-0001.sig>
