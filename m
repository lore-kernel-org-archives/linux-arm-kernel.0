From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Wed, 29 Nov 2017 10:36:39 +0200
Subject: [PATCH V3 22/29] [media] atomisp: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511801886-6753-23-git-send-email-okaya@codeaurora.org>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
 <1511801886-6753-23-git-send-email-okaya@codeaurora.org>
Message-ID: <20171129083639.meuue7eooybr5u7o@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

On Mon, Nov 27, 2017 at 11:57:59AM -0500, Sinan Kaya wrote:
> diff --git a/drivers/staging/media/atomisp/platform/intel-mid/intel_mid_pcihelpers.c b/drivers/staging/media/atomisp/platform/intel-mid/intel_mid_pcihelpers.c
> index 4631b1d..51dcef57 100644
> --- a/drivers/staging/media/atomisp/platform/intel-mid/intel_mid_pcihelpers.c
> +++ b/drivers/staging/media/atomisp/platform/intel-mid/intel_mid_pcihelpers.c
> @@ -39,7 +39,7 @@ static inline int platform_is(u8 model)
>  
>  static int intel_mid_msgbus_init(void)
>  {
> -	pci_root = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
> +	pci_root = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
>  	if (!pci_root) {
>  		pr_err("%s: Error: msgbus PCI handle NULL\n", __func__);
>  		return -ENODEV;

This file has been removed, I'm applying the rest of the patch.

Please use the media tree as the base in the future. Thanks.

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi
