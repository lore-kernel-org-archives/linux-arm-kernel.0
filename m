From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Mar 2016 12:01:21 +0100
Subject: [RFC 14/15] usb: xhci: mtk: Add missing MFD_SYSCON dependency on
 HAS_IOMEM
In-Reply-To: <1456992221-26712-15-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <1456992221-26712-15-git-send-email-k.kozlowski@samsung.com>
Message-ID: <2531852.vizHtxotvy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 17:03:40 Krzysztof Kozlowski wrote:
> index 8c20ebbc049c..f759a778d606 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -45,6 +45,7 @@ config USB_XHCI_PLATFORM
>  
>  config USB_XHCI_MTK
>         tristate "xHCI support for Mediatek MT65xx"
> +       depends on HAS_IOMEM    # For MFD_SYSCON
>         select MFD_SYSCON
>         depends on ARCH_MEDIATEK || COMPILE_TEST
>         ---help---
> 

This already has the dependency, as it depends on XHCD_PLATFORM
which depends on HAS_IOMEM.

	Arnd
