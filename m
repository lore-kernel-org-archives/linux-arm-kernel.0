From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 24 Jan 2013 21:32:46 -0800
Subject: [PATCH v3 1/4] drivers: usb: phy: add a new driver for usb part
 of control module
In-Reply-To: <1359080391-5120-2-git-send-email-kishon@ti.com>
References: <1359080391-5120-1-git-send-email-kishon@ti.com>
 <1359080391-5120-2-git-send-email-kishon@ti.com>
Message-ID: <510218FE.8080606@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2013 06:19 PM, Kishon Vijay Abraham I wrote:
> Added a new driver for the usb part of control module. This has an API
> to power on the USB2 phy and an API to write to the mailbox depending on
> whether MUSB has to act in host mode or in device mode.
> 
> Writing to control module registers for doing the above task which was
> previously done in omap glue and in omap-usb2 phy will be removed.

> diff --git a/Documentation/devicetree/bindings/usb/usb-phy.txt b/Documentation/devicetree/bindings/usb/usb-phy.txt

This file seems to be specific to the TI USB PHYs, not all USB PHYs;
shouldn't it be renamed ti-usb-phy.txt, or even better renamed to match
the compatible value it documents, giving ti,omap-usb2.txt?

>  add the address of control module dev conf register until a driver for
>  control module is added
>  
> +Optional properties:
> + - ctrl_module : phandle of the control module used by PHY driver to power on
> +   the PHY.

DT property names generally use - not _ as the word separator.
