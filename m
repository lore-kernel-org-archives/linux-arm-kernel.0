From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Tue, 10 Oct 2017 10:36:42 +0000
Subject: [PATCH v2] extcon: Split out extcon header file for consumer and
 provider device
In-Reply-To: <1507630671-23536-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20171010101758epcas2p3b3f379076f5be5e81edee2bd00354c28@epcas2p3.samsung.com>
 <1507630671-23536-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <TY1PR06MB09928903CD7F333B35C2C17DD8750@TY1PR06MB0992.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> From: Chanwoo Choi, Sent: Tuesday, October 10, 2017 7:18 PM
> 
> The extcon has two type of extcon devices as following.
> - 'extcon provider deivce' adds new extcon device and detect the
>    state/properties of external connector. Also, it notifies the
>    state/properties to the extcon consumer device.
> - 'extcon consumer device' gets the change state/properties
>    from extcon provider device.
> Prior to that, include/linux/extcon.h contains all exported API for
> both provider and consumer device driver. To clarify the meaning of
> header file and to remove the wrong use-case on consumer device,
> this patch separates into extcon.h and extcon-provider.h.
> 
> [Description for include/linux/{extcon.h|extcon-provider.h}]
> - extcon.h includes the extcon API and data structure for extcon consumer
>   device driver. This header file contains the following APIs:
>   : Register/unregister the notifier to catch the change of extcon device
>   : Get the extcon device instance
>   : Get the extcon device name
>   : Get the state of each external connector
>   : Get the property value of each external connector
>   : Get the property capability of each external connector
> 
> - extcon-provider.h includes the extcon API and data structure for extcon
>   provider device driver. This header file contains the following APIs:
>   : Include 'include/linux/extcon.h'
>   : Allocate the memory for extcon device instance
>   : Register/unregister extcon device
>   : Set the state of each external connector
>   : Set the property value of each external connector
>   : Set the property capability of each external connector
> 
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes from v1:
> - Don't touch drivers/usb/renesas_usbhs/common.h.
> - Add acked-by from Sebastian Reichel (for drivers/power/supply/)
> - Add acked-by from Chen-Yu Tsai (for phy-sun4i-usb.c & extcon-axp288.c)
> - Add acked-by from Charles Keepax (for drivers/extcon/extcon-arizona.c)
> - Add acked-by from Lee Jones (fo include/linux/mfd/palmas.h)
< snip >
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c      |   2 +-

and

< snip >
>  drivers/usb/gadget/udc/renesas_usb3.c         |   2 +-

Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda
