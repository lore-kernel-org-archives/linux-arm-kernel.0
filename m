From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Oct 2015 14:55:38 +0200
Subject: [PATCH v2] VFIO: platform: reset: AMD xgbe reset module
In-Reply-To: <1445604253-15384-1-git-send-email-eric.auger@linaro.org>
References: <1445604253-15384-1-git-send-email-eric.auger@linaro.org>
Message-ID: <4421151.hWFIfrRvFW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 October 2015 14:44:13 Eric Auger wrote:
> This patch introduces a module that registers and implements a low-level
> reset function for the AMD XGBE device.
> 
> it performs the following actions:
> - reset the PHY
> - disable auto-negotiation
> - disable & clear auto-negotiation IRQ
> - soft-reset the MAC
> 
> Those tiny pieces of code are inherited from the native xgbe driver.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> ---

The code looks ok to me, just two small style issues.
>  
>  	  If you don't know what to do here, say N.
> +config VFIO_PLATFORM_AMDXGBE_RESET
> +	tristate "VFIO support for AMD XGBE reset"
> +	depends on VFIO_PLATFORM
> +	help
> +	  Enables the VFIO platform driver to handle reset for AMD XGBE
> +
> +	  If you don't know what to do here, say N.

Please add an empty line before the newly introduced option.

> +MODULE_VERSION(DRIVER_VERSION);
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR(DRIVER_AUTHOR);
> +MODULE_DESCRIPTION(DRIVER_DESC);

Best remove those macros and put the strings in here directly to
make it easier to grep for.

	Arnd
