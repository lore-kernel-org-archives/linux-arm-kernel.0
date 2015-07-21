From: balbi@ti.com (Felipe Balbi)
Date: Tue, 21 Jul 2015 11:43:32 -0500
Subject: [PATCH v3 07/46] usb: dwc3: gadget: add ep capabilities support
In-Reply-To: <1436941953-1327-8-git-send-email-r.baldyga@samsung.com>
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
 <1436941953-1327-8-git-send-email-r.baldyga@samsung.com>
Message-ID: <20150721164331.GG25385@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 15, 2015 at 08:31:54AM +0200, Robert Baldyga wrote:
> Convert endpoint configuration to new capabilities model.
> 
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>  drivers/usb/dwc3/gadget.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 333a7c0..8d1f768 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1713,6 +1713,19 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
>  				return ret;
>  		}
>  
> +		if (epnum == 0) {
> +			dep->endpoint.caps.type_control = true;

as the name says, this function deals with hw endpoints. This means ep1
is also control.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150721/a80db706/attachment-0001.sig>
