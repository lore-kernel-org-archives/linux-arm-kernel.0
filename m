From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 22:19:19 -0600
Subject: [PATCH v6 02/15] usb: phy-mxs: Add platform judgement code
In-Reply-To: <1386897825-6130-3-git-send-email-peter.chen@freescale.com>
References: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
 <1386897825-6130-3-git-send-email-peter.chen@freescale.com>
Message-ID: <20131213041918.GC867@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 09:23:32AM +0800, Peter Chen wrote:
> The mxs-phy has several bugs and features at different
> versions, the driver code can get it through of_device_id.data.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/phy/phy-mxs-usb.c |   58 ++++++++++++++++++++++++++++++++++------
>  1 files changed, 49 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> index 545844b..6d49040 100644
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright 2012-2013 Freescale Semiconductor, Inc.
>   * Copyright (C) 2012 Marek Vasut <marex@denx.de>
>   * on behalf of DENX Software Engineering GmbH
>   *
> @@ -20,6 +20,7 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/of_device.h>
>  
>  #define DRIVER_NAME "mxs_phy"
>  
> @@ -34,13 +35,55 @@
>  #define BM_USBPHY_CTRL_ENUTMILEVEL2		BIT(14)
>  #define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	BIT(1)
>  
> +#define to_mxs_phy(p) container_of((p), struct mxs_phy, phy)

defined, but never used.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/e5011fca/attachment.sig>
