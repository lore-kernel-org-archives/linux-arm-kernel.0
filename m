From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 07 Feb 2013 11:49:42 -0700
Subject: [PATCH 06/10] USB: EHCI: make ehci-s5p a separate driver
In-Reply-To: <5113e616.c84e420a.08c3.ffffbeed@mx.google.com>
References: <yes> <1360258447-27247-1-git-send-email-yes>
 <5113e616.c84e420a.08c3.ffffbeed@mx.google.com>
Message-ID: <5113F746.2050907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2013 10:34 AM, manjunath.goudar at linaro.org wrote:
> Separate the s5p host controller driver from ehci-hcd host code
> into its own driver module.

> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c

> @@ -1297,11 +1297,6 @@ MODULE_LICENSE ("GPL");
>  #define	PLATFORM_DRIVER		ehci_hcd_msp_driver
>  #endif
>  
> -#ifdef CONFIG_USB_EHCI_TEGRA
> -#include "ehci-tegra.c"
> -#define PLATFORM_DRIVER		tegra_ehci_driver
> -#endif
> -

That also looks wrong.
