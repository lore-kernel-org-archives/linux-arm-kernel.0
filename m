From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Nov 2015 10:38:18 +0100
Subject: [PATCH] USB: USB_OTG does not depend on PM
In-Reply-To: <20151118031748.GA4228@shlinux2>
References: <7521777.8ZmnT3AlIC@wuerfel> <5647698.81XCu85L5D@wuerfel>
 <20151118031748.GA4228@shlinux2>
Message-ID: <5217888.FiujFV8yJj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 November 2015 11:17:50 Peter Chen wrote:
> From 3a6918dae038aadc200dcf0263f4440acc2353d4 Mon Sep 17 00:00:00 2001
> From: Peter Chen <peter.chen@freescale.com>
> Date: Wed, 18 Nov 2015 11:06:34 +0800
> Subject: [PATCH 1/1] usb: kconfig: fix warning of select USB_OTG
> 
> When choose randconfig for kernel build, it reports below warning:
> "warning: (USB_OTG_FSM && FSL_USB2_OTG && USB_MV_OTG) selects USB_OTG
> which has unmet direct dependencies (USB_SUPPORT && USB && PM)"
> 
> In fact, USB_OTG is visual symbol and depends on PM, so the driver

                      visible ?

> needs to depend on it to reduce dependency problem.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Felipe Balbi <balbi@ti.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I was a bit worried that this might break defconfig files that now
no longer automatically get OSB_OTG enabled, but I have checked all
defconfig files we have in the kernel and none of them uses
USB_OTG_FSM, FSL_USB2_OTG or USB_MV_OTG, so we are fine.

Thanks!

	Arnd
