From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Jun 2013 15:49:24 +0200
Subject: [RFC][PATCH 1/7] USB: OHCI: make ohci-exynos a separate driver
In-Reply-To: <1370585013-12809-2-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
 <1370585013-12809-2-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <6754704.rVr58LLFvc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013 11:33:27 Manjunath Goudar wrote:
> 
>  #if    !IS_ENABLED(CONFIG_USB_OHCI_HCD_PCI) && \
>         !IS_ENABLED(CONFIG_USB_OHCI_HCD_PLATFORM) && \
> +       !IS_ENABLED(CONFIG_USB_OHCI_EXYNOS) && \
>         !defined(PLATFORM_DRIVER) &&    \
>         !defined(OMAP1_PLATFORM_DRIVER) &&      \
>         !defined(OMAP3_PLATFORM_DRIVER) &&      \
> @@ -1269,7 +1265,6 @@ MODULE_LICENSE ("GPL");
>         !defined(SM501_OHCI_DRIVER) && \
>         !defined(TMIO_OHCI_DRIVER) && \
>         !defined(S3C2410_PLATFORM_DRIVER) && \
> -       !defined(EXYNOS_PLATFORM_DRIVER) && \
>         !defined(EP93XX_PLATFORM_DRIVER) && \
>         !defined(AT91_PLATFORM_DRIVER) && \
>         !defined(NXP_PLATFORM_DRIVER) && \

Hi Manjunath,

please note that Greg just merged my patch to remove this entire list and
the #error statement. The next time you rebase your patch, you will have
to remove this hunk in each of your patches.

	Arnd
