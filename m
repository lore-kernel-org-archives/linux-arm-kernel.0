From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 17:14:06 +0200
Subject: [PATCH 06/10] usb: musb: ux500: add device tree probing support
In-Reply-To: <1366729394-11406-7-git-send-email-lee.jones@linaro.org>
References: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
 <1366729394-11406-7-git-send-email-lee.jones@linaro.org>
Message-ID: <201304231714.06326.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 April 2013, Lee Jones wrote:
> +Required properties:
> + - compatible : Should be "stericsson,db8500-musb"
> + - reg        : Offset and length of registers
> + - interrupts : Interrupt; mode, number and trigger
> + - mode       : One of; "host", "otg", or "peripheral"

I think we don't have any precedent for this combination of "mode" property
and contents. You could either try to match ehci-omap.txt and do

 - mode : Should be "3" to represent OTG. "1" signifies HOST and "2"
   represents PERIPHERAL.

Or you match fsl-usb.txt and nvidia,tegra20-ehci.txt, defining

 - dr_mode : dual role mode. Indicates the working mode to
   controllers.  Can be "host", "peripheral", or "otg".  Default to
   "host" if not defined for backward compatibility.

> +Optional properties:
> + - dmas       : A list of dma channels;
> +                dma-controller, event-line, fixed-channel, flags
> + - dma-names  : An ordered list of channel names affiliated to the above

Please list the exact dma-names that are required.

	Arnd
