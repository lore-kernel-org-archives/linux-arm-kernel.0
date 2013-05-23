From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 May 2013 15:26:48 +0200
Subject: [RFC PATCH 2/3] USB: OHCI: Generic changes to make ohci-pci a
 separate driver
In-Reply-To: <1369307506-4458-3-git-send-email-manjunath.goudar@linaro.org>
References: <1365746856-7772-2-git-send-email-manjunath.goudar@linaro.org>
 <1369307506-4458-1-git-send-email-manjunath.goudar@linaro.org>
 <1369307506-4458-3-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <201305231526.48811.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 May 2013, Manjunath Goudar wrote:
> @@ -1275,7 +1266,7 @@ MODULE_LICENSE ("GPL");
>  #define PLATFORM_DRIVER                ohci_platform_driver
>  #endif
>  
> -#if    !defined(PCI_DRIVER) &&         \
> +#if    !defined(PCI_DRIVER) && \
>         !defined(PLATFORM_DRIVER) &&    \
>         !defined(OMAP1_PLATFORM_DRIVER) &&      \
>         !defined(OMAP3_PLATFORM_DRIVER) &&      \

This part didn't really belong here, otherwise the patch looks right to me.

	Arnd
