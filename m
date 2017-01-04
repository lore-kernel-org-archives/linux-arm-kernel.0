From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 04 Jan 2017 15:31:26 +0200
Subject: [RFC PATCH] usb: dwc3: add support for OTG driver compilation
In-Reply-To: <1483536181-22356-2-git-send-email-mnarani@xilinx.com>
References: <1483536181-22356-1-git-send-email-mnarani@xilinx.com>
 <1483536181-22356-2-git-send-email-mnarani@xilinx.com>
Message-ID: <87r34jvtn5.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Manish Narani <manish.narani@xilinx.com> writes:
> This patch adds support for OTG driver compilation and object
> file creation
>
> Signed-off-by: Manish Narani <mnarani@xilinx.com>
> ---
>  drivers/usb/dwc3/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> index ffca340..2d269ad 100644
> --- a/drivers/usb/dwc3/Makefile
> +++ b/drivers/usb/dwc3/Makefile
> @@ -17,6 +17,10 @@ ifneq ($(filter y,$(CONFIG_USB_DWC3_GADGET) $(CONFIG_USB_DWC3_DUAL_ROLE)),)
>  	dwc3-y				+= gadget.o ep0.o
>  endif
>  
> +ifneq ($(CONFIG_USB_DWC3_DUAL_ROLE),)
> +	dwc3-y				+= otg.o
> +endif

you just broke compilation

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170104/5e6aebb4/attachment.sig>
