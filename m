From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Jul 2013 10:49:47 -0600
Subject: Board-specific GPIO setup code
In-Reply-To: <51F568AD.8030001@prisktech.co.nz>
References: <51F568AD.8030001@prisktech.co.nz>
Message-ID: <51F69D2B.6030605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2013 12:53 PM, Tony Prisk wrote:
> On the Wandboard (IMX6Q SoC), there is a WiFi module connected via SDIO
> that requires a reset procedure to enable it. This would be board
> specific setup, but gpio_* functions can't be used in
> arch/arm/mach-imx/imx6q.c
> 
> What would be the correct place to perform the reset code (basically a
> series of gpio calls) to reset the WiFi controller or should it be done
> earlier in uboot?

The correct approach is probably to enhance the SDIO controller (or SDIO
core) to know how to power/reset/... the device that's attached to it.
For WiFi, this probably also includes turning on a clock to the
conencted device too. Hopefully this is all common enough that the same
set of signals/sequencing/... works for all connected devices, so we
don't have to do custom stuff on different boards.
