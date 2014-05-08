From: yoshihiro.shimoda.uh@renesas.com (Shimoda, Yoshihiro)
Date: Thu, 8 May 2014 11:44:48 +0900
Subject: [PATCHv4 08/20] usb: host: xhci-plat: add support for the Armada
 375/38x XHCI controllers
In-Reply-To: <1399470746-2948-9-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399470746-2948-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399470746-2948-9-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <536AEFA0.3070806@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

(2014/05/07 22:52), Thomas Petazzoni wrote:
> diff --git a/drivers/usb/host/xhci-mvebu.h b/drivers/usb/host/xhci-mvebu.h
> new file mode 100644
> index 0000000..61d09b6
> --- /dev/null
> +++ b/drivers/usb/host/xhci-mvebu.h
> @@ -0,0 +1,21 @@
> +/*
> + * Copyright (C) 2014 Marvell
> + *
> + * Gregory Clement <gregory.clement@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __LINUX_XHCI_MVEBU_H
> +#define __LINUX_XHCI_MVEBU_H
> +#if IS_ENABLED(CONFIG_USB_XHCI_MVEBU)
> +int xhci_mvebu_mbus_init_quirk(struct platform_device *pdev);
> +#else
> +static inline int xhci_mvebu_mbus_init_quirk(struct device dev)

I could not compile this code when I disabled CONFIG_USB_XHCI_MVEBU:
	incompatible type for argument 1 of 'xhci_mvebu_mbus_init_quirk'.

So, the "struct device dev" should be changed to "struct platform_device *pdev".

Best regards,
Yoshihiro Shimoda
