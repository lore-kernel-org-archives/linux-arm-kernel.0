From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 02 May 2012 15:52:23 +0400
Subject: [PATCH 1/1] Add missing include <plat/cpu.h> in
 drivers/mfd/omap-usb-host.c
In-Reply-To: <4FA02CE9.3090106@free.fr>
References: <4FA02CE9.3090106@free.fr>
Message-ID: <4FA11FF7.8040600@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-05-2012 22:35, Guillaume Gardet wrote:

> Fix compilation error for omap boards (beagleboard, etc.) due to missing
> include <plat/cpu.h> in drivers/mfd/omap-usb-host.c leading to build error
> (unknown cpu_is_omap3430, omap_rev and OMAP3430_REV_ES2_1).

> KernelVersion: 3.4-rc5

    This should have been specified under --- tear line.

> Signed-off-by: Guillaume GARDET<guillaume.gardet@free.fr>

> ---
> drivers/mfd/omap-usb-host.c | 1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index c8aae66..7e96bb2 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -25,6 +25,7 @@
>  #include<linux/clk.h>
>  #include<linux/dma-mapping.h>
>  #include<linux/spinlock.h>
> +#include<plat/cpu.h>
>  #include<plat/usb.h>
>  #include<linux/pm_runtime.h>

    Something ate spaces between #include and < in your patch (this time it's 
not my Thunderbird).

WBR, Sergei
