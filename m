From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jul 2012 16:23:29 +0000
Subject: [PATCH] USB: ohci-pxa27x: add DT bindings
In-Reply-To: <1343231301-8987-1-git-send-email-zonque@gmail.com>
References: <1343231301-8987-1-git-send-email-zonque@gmail.com>
Message-ID: <201207251623.30476.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 July 2012, Daniel Mack wrote:

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/pxa-usb.txt
> @@ -0,0 +1,31 @@
> +PXA USB controllers
> +
> +OHCI
> +
> +Required properties:
> + - compatible: Should be "mrvl,pxa-ohci" for USB controllers
> +   used in host mode.
> +
> +Optional properties:
> + - "mrvl,enable-port1", "mrvl,enable-port2", "mrvl,enable-port3"
> +   If present, enables the appropriate USB port of the controller.
> + - "mrvl,port-mode" selects the mode of the ports:
> +	1 = PMM_NPS_MODE
> +	2 = PMM_GLOBAL_MODE
> +	3 = PMM_PERPORT_MODE
> + - "mrvl,power-sense-low" - power sense pin is low-active.
> + - "mrvl,power-control-low" - power control pin is low-active.
> + - "mrvl,no-oc-protection" - disable over-current protection.
> + - "mrvl,oc-mode-perport" - enable per-port over-current protection.
> + - "mrvl,power_on_delay" Power On to Power Good time - in ms.
>

We're in the process of changing all uses of "mrvl" to "marvell"
so we use the same everywhere. Please change this too.

For the various flags, I wonder which ones actually depend on 
the board configuration and which ones depend only on the
SoC variant that is used. If they are just different between
SoCs, I would recommend using different "compatible"
values and looking up the entire flags word. If most of
them are board specific, better leave it like you have now.

For the three enable-port* values, I think using a bit mask
would be slightly nicer, but your version is fine too.

	Arnd
