From: marex@denx.de (Marek Vasut)
Date: Wed, 15 Apr 2015 04:59:58 +0200
Subject: [PATCH] ARM: dts: imx23-olinuxino: Fix dr_mode of usb0
In-Reply-To: <1429043846-28731-1-git-send-email-stefan.wahren@i2se.com>
References: <1429043846-28731-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <201504150459.58238.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 14, 2015 at 10:37:26 PM, Stefan Wahren wrote:
> The dr_mode of usb0 on imx233-olinuxino is left to default "otg".
> Since the green LED (GPIO2_1) on imx233-olinuxino is connected to the
> same pin as USB_OTG_ID it's possible to disable USB host by LED toggling:
> 
> echo 0 > /sys/class/leds/green/brightness
> [ 1068.890000] ci_hdrc ci_hdrc.0: remove, state 1
> [ 1068.890000] usb usb1: USB disconnect, device number 1
> [ 1068.920000] usb 1-1: USB disconnect, device number 2
> [ 1068.920000] usb 1-1.1: USB disconnect, device number 3
> [ 1069.070000] usb 1-1.2: USB disconnect, device number 4
> [ 1069.450000] ci_hdrc ci_hdrc.0: USB bus 1 deregistered
> [ 1074.460000] ci_hdrc ci_hdrc.0: timeout waiting for 00000800 in 11
> 
> This patch fixes the issue by setting dr_mode to "host" in the dts file.
> 
> Reported-by: Harald Geyer <harald@ccbib.org>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
