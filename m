From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 10 Mar 2011 14:06:04 +0100
Subject: [PATCH 1/8] macb: unify at91 and avr32 platform data
In-Reply-To: <1299751843-9743-2-git-send-email-jamie@jamieiles.com>
References: <1299751843-9743-1-git-send-email-jamie@jamieiles.com>
	<1299751843-9743-2-git-send-email-jamie@jamieiles.com>
Message-ID: <4D78CCBC.2010807@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/10/2011 11:10 AM, Jamie Iles :
> --- a/drivers/net/macb.c
> +++ b/drivers/net/macb.c
> @@ -18,12 +18,10 @@
>  #include <linux/netdevice.h>
>  #include <linux/etherdevice.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/platform_data/macb.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy.h>
>  
> -#include <mach/board.h>
> -#include <mach/cpu.h>

I did not bouble check but do we need no more cpu_is_ macros?

> -
>  #include "macb.h"
>  
>  #define RX_BUFFER_SIZE		128

-- 
Nicolas Ferre
