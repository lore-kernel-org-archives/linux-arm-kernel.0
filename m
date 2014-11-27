From: baolu.lu@linux.intel.com (Lu, Baolu)
Date: Thu, 27 Nov 2014 10:00:27 +0800
Subject: [PATCH 06/19] usb: dwc3: host: Pass the XHCI_DRD_SUPPORT and
 XHCI_NEEDS_LHC_RESET quirk
In-Reply-To: <1416921115-10467-7-git-send-email-george.cherian@ti.com>
References: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
 <1416921115-10467-7-git-send-email-george.cherian@ti.com>
Message-ID: <547685BB.3020109@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2014?11?25? 21:11, George Cherian wrote:
> Pass the quir flag XHCI_DRD_SUPPORT from DWC3 host to xhci platform driver.
"quir" to "quirk"

Regards,
Baolu

> This enables xhci driver to handle deallocation's differently while in DRD mode.
> Pass the quirk flag XHCI_NEEDS_LHC_RESET from DWC3 host to xhci platform
> driver. This enables to do LHRESET during xhci_reset().
>
> Signed-off-by: George Cherian <george.cherian@ti.com>
> ---
>   drivers/usb/dwc3/host.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index dcb8ca0..257b5b5 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -53,6 +53,8 @@ int dwc3_host_init(struct dwc3 *dwc)
>   #ifdef CONFIG_DWC3_HOST_USB3_LPM_ENABLE
>   	pdata.usb3_lpm_capable = 1;
>   #endif
> +	pdata.usb_drd_support = 1;
> +	pdata.usb_needs_lhc_reset = 1;
>   
>   	ret = platform_device_add_data(xhci, &pdata, sizeof(pdata));
>   	if (ret) {
