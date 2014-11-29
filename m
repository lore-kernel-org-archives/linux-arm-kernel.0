From: jmmahler@gmail.com (Jeremiah Mahler)
Date: Sat, 29 Nov 2014 14:44:48 -0800
Subject: [PATCH v2 2/3] usb: phy: add lubbock phy driver
In-Reply-To: <1417298525-5587-3-git-send-email-dbaryshkov@gmail.com>
References: <1417298525-5587-1-git-send-email-dbaryshkov@gmail.com>
 <1417298525-5587-3-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20141129224448.GA1607@hudson.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry,

On Sun, Nov 30, 2014 at 01:02:04AM +0300, Dmitry Eremin-Solenikov wrote:
> Extract lubbock-specific code from pxa25x_udc driver. As a bonus, phy
> 
[]
> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> index 0cd1f44..98b1682 100644
> --- a/drivers/usb/phy/Kconfig
> +++ b/drivers/usb/phy/Kconfig
> @@ -137,6 +137,16 @@ config USB_ISP1301
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called phy-isp1301.
>  
> +config USB_LUBBOCK
> +	tristate "USB VBUS PHY Driver for DBPXA250 Lubbock platform"
> +	depends on ARCH_LUBBOCK
> +	help
> +	  Say Y here to add support for the USB Gadget VBUS tranceiver driver
                                                        ^^^^^^^^^^
                                                        transceiver
> +	  for DBPXA250 (Lubbock) platform.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called phy-lubbock.
> +
>  config USB_MSM_OTG
>  	tristate "Qualcomm on-chip USB OTG controller support"
>  	depends on (USB || USB_GADGET) && (ARCH_MSM || ARCH_QCOM || COMPILE_TEST)
> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
> +};
[]
> +module_platform_driver(lubbock_vbus_driver);
> +
> +MODULE_DESCRIPTION("OTG transceiver driver for DBPXA250 Lubbock platform");
> +MODULE_AUTHOR("Dmitry Eremin-Solenikov");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.1.3
> 
> --
[]

-- 
- Jeremiah Mahler
