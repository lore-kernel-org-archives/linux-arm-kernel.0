From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 20 Jun 2013 13:10:14 +0900
Subject: [PATCH V2 1/6] USB: OHCI: make ohci-exynos a separate driver
In-Reply-To: <1371052442-14541-2-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
 <1371052442-14541-1-git-send-email-manjunath.goudar@linaro.org>
 <1371052442-14541-2-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <00ba01ce6d6c$10e8a260$32b9e720$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 13, 2013 12:54 AM, Manjunath Goudar wrote:
> 
> Separate the  Samsung OHCI EXYNOS host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> it would be nice to have in 3.11.
> 
> V2:
>  -exynos_ohci_hcd structure assignment error fixed.
>  -Removed multiple usb_create_hcd() from prob funtion.
>  -platform_set_drvdata() called before exynos_ohci_phy_enable().
>  -ohci_setup() removed because it is called in .reset member
>   of the ohci_hc_driver structure
> 
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Greg KH <greg@kroah.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-usb at vger.kernel.org
> ---
>  drivers/usb/host/Kconfig       |    2 +-
>  drivers/usb/host/Makefile      |    1 +
>  drivers/usb/host/ohci-exynos.c |  167 +++++++++++++++++-----------------------
>  drivers/usb/host/ohci-hcd.c    |   18 -----
>  4 files changed, 71 insertions(+), 117 deletions(-)

CC'ed Vivek Gautam

Hi Manjunath Goudar,

It looks good.
I tested this patch on Exynos4210. It works properly.
I really appreciate your work.

Acked-by: Jingoo Han <jg1.han@samsung.com>


Also, I agree on Alan's opinion.
> +#define DRIVER_DESC "OHCI exynos driver"
Please, replace 'exynos' with 'EXYNOS'.

Best regards,
Jingoo Han
