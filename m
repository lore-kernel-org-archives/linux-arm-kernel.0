From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 30 Jul 2011 23:54:17 +0200
Subject: [PATCH] usb/ehci-mxc: add missing inclusion of mach/hardware.h
In-Reply-To: <1311258250-22013-1-git-send-email-shawn.guo@linaro.org>
References: <1311258250-22013-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110730215417.GB26262@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 10:24:10PM +0800, Shawn Guo wrote:
> As cpu_is_mx stuff is being used in the driver, header mach/hardware.h
> should be explicitly included.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> The missing of the header is causing today's linux-next build error
> as bleow.
> 
>   CC      drivers/usb/host/ehci-hcd.o
> In file included from linux-next/drivers/usb/host/ehci-hcd.c:1190:0:
> linux-next/drivers/usb/host/ehci-mxc.c: In function 'ehci_mxc_drv_probe':
> linux-next/drivers/usb/host/ehci-mxc.c:175:2: error: implicit declaration of function 'cpu_is_mx35'
> linux-next/drivers/usb/host/ehci-mxc.c:175:2: error: implicit declaration of function 'cpu_is_mx25'
> linux-next/drivers/usb/host/ehci-mxc.c:185:2: error: implicit declaration of function 'cpu_is_mx51'
I just hit this problem while build testing some of my patches.

IMHO the build failure can go in the commit log, too.

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
