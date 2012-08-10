From: balbi@ti.com (Felipe Balbi)
Date: Fri, 10 Aug 2012 10:06:24 +0300
Subject: [PATCH v4 0/5] usb: phy: samsung: Introducing usb phy driver for
 samsung SoCs
In-Reply-To: <1344582631-13658-1-git-send-email-p.paneri@samsung.com>
References: <1344582631-13658-1-git-send-email-p.paneri@samsung.com>
Message-ID: <20120810070623.GL1689@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 12:40:26PM +0530, Praveen Paneri wrote:
> Changes from v3:
> Replaced susbsys_initcall()/module_exit() by module_platform_driver().
> Accordingly in the hsotg driver returned -EPROBE_DEFER until phy driver
> is registered
> Removed unnecessary devm_usb_put_phy() call from the hsotg driver remove.
> 
> Changes from v2:
> Changed the driver filenames to samsung-usbphy
> Changed 's3c' to 'samsung' for platform device as well as platform data
> Moved platform data structure to a separate file
> Rectified coding style related errors
> 
> Changes from v1:
> Rebased patches to latest usb-next branch
> Changed the name 'sec_usbphy' to 'samsung_usbphy'
> 
> This patch set introduces a phy driver for samsung SoCs. It uses the existing
> transceiver infrastructure to provide phy control functions. Use of this driver
> can be extended for usb host phy as well. Over the period of time all the phy
> related code for most of the samsung SoCs can be integrated here.
> Removing the existing phy code from mach-s3c64xx. Same can be done for other SoCs
> when they start supporting this phy driver. 
> This driver is tested with smdk6410 and Exynos4210(with DT).
> 
> Praveen Paneri (5):
>   usb: phy: samsung: Introducing usb phy driver for hsotg
>   usb: s3c-hsotg: Adding phy driver support
>   ARM: S3C64XX: Removing old phy setup code
>   ARM: S3C64XX: Enabling samsung-usbphy driver
>   ARM: Exynos4210: Enabling samsung-usbphy driver

just one idea. It looks like after introducing the PHY, you converted
all users to create the phy device. I wonder if you should have a
patch 6/6 which will remove pdata->init support from s3c_hsotg.c and
stick to using phy driver.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120810/2ddf73c1/attachment.sig>
