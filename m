From: greg@kroah.com (Greg KH)
Date: Thu, 26 Sep 2013 09:50:50 -0700
Subject: [PATCH V5 1/9] USB: OHCI: make ohci-exynos a separate driver
In-Reply-To: <1379761727-10656-2-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
 <1379761727-10656-1-git-send-email-manjunath.goudar@linaro.org>
 <1379761727-10656-2-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <20130926165050.GA27342@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 21, 2013 at 04:38:38PM +0530, Manjunath Goudar wrote:
> Separate the  Samsung OHCI EXYNOS host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM.
> 
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> Cc: Vivek Gautam <gautam.vivek@samsung.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Greg KH <greg@kroah.com>
> Cc: linux-usb at vger.kernel.org
> 
> V2->V3:
>  -No major changes only "exynos" written in capital letters
>   in "OHCI exynos driver".
> 
> V1->V2:
>  -exynos_ohci_hcd structure assignment error fixed.
>  -Removed multiple usb_create_hcd() from prob funtion.
>  -platform_set_drvdata() called before exynos_ohci_phy_enable().
>  -ohci_setup() removed because it is called in .reset member
>   of the ohci_hc_driver structure
> ---

In the future, these "version" lines need to go below the cut ("---"),
not above it, as I need to edit these patches by hand to remove them now
:(

thanks,

greg k-h
