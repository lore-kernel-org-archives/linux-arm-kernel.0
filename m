From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 20 Nov 2009 14:21:29 +0000
Subject: [PATCH 1/2] ARM: PNX4008: fix i2c-pnx.c build errors
In-Reply-To: <f639bcd4278415ccf72dbc3b602670ac4dab040d.1258725164.git.rmk+kernel@arm.linux.org.uk>
References: <20091120135932.GA16920@n2100.arm.linux.org.uk>
	<f639bcd4278415ccf72dbc3b602670ac4dab040d.1258725164.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <20091120142128.GE4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2009 at 11:03:29AM +0000, Russell King - ARM Linux wrote:
> ... caused by a missing include.

hi, thought this was fixed by the last fix set I sent which went in post
2.6.32-rc8.
 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/i2c/busses/i2c-pnx.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
> index 6ff6c20..3ae5647 100644
> --- a/drivers/i2c/busses/i2c-pnx.c
> +++ b/drivers/i2c/busses/i2c-pnx.c
> @@ -22,6 +22,7 @@
>  #include <mach/hardware.h>
>  #include <asm/irq.h>
>  #include <asm/uaccess.h>
> +#include <mach/i2c.h>
>  
>  #define I2C_PNX_TIMEOUT		10 /* msec */
>  #define I2C_PNX_SPEED_KHZ	100
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
