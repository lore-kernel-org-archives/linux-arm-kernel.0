From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Tue, 7 Aug 2012 10:11:22 +0200
Subject: [PATCH v2 1/5] usb: phy: samsung: Introducing usb phy driver for
 hsotg
In-Reply-To: <1344324524-2286-2-git-send-email-p.paneri@samsung.com>
References: <1344324524-2286-1-git-send-email-p.paneri@samsung.com>
 <1344324524-2286-2-git-send-email-p.paneri@samsung.com>
Message-ID: <201208071011.23558.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 7. August 2012, 09:28:40 schrieb Praveen Paneri:
> This driver uses usb_phy interface to interact with s3c-hsotg. Supports
> phy_init and phy_shutdown functions to enable/disable phy. Tested with
> smdk6410 and smdkv310. More SoCs can be brought under later.
>
> Signed-off-by: Praveen Paneri <p.paneri@samsung.com>
> ---
>  .../devicetree/bindings/usb/samsung-usbphy.txt     |    9 +
>  drivers/usb/phy/Kconfig                            |    8 +
>  drivers/usb/phy/Makefile                           |    1 +
>  drivers/usb/phy/samsung_usbphy.c                   |  355
> ++++++++++++++++++++ drivers/usb/phy/samsung_usbphy.h                   | 
>  48 +++
>  include/linux/platform_data/s3c-hsotg.h            |    5 +
>  6 files changed, 426 insertions(+), 0 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/usb/samsung-usbphy.txt create mode
> 100644 drivers/usb/phy/samsung_usbphy.c
>  create mode 100644 drivers/usb/phy/samsung_usbphy.h
> 

[...]

> diff --git a/include/linux/platform_data/s3c-hsotg.h
> b/include/linux/platform_data/s3c-hsotg.h index 8b79e09..25ed31e 100644
> --- a/include/linux/platform_data/s3c-hsotg.h
> +++ b/include/linux/platform_data/s3c-hsotg.h
> @@ -35,6 +35,11 @@ struct s3c_hsotg_plat {
>  	int (*phy_exit)(struct platform_device *pdev, int type);
>  };
> 
> +struct s3c_usbphy_plat {
> +	void (*pmu_isolation)(int on);
> +};
> +
>  extern void s3c_hsotg_set_platdata(struct s3c_hsotg_plat *pd);
> +extern void s3c_usbphy_set_platdata(struct s3c_usbphy_plat *pd);
> 
>  #endif /* __LINUX_USB_S3C_HSOTG_H */

hmm, I'm not completely sure about this being in the s3c-hsotg header, as on 
s3c2443/2416/2450 it's the s3c-hsudc that will be (hopefully) using the phy in 
the future.


Heiko
