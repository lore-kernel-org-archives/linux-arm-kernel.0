From: jdelvare@suse.de (Jean Delvare)
Date: Mon, 26 May 2014 17:34:01 +0200
Subject: [PATCH] gpio: pch: include linux/slab.h
In-Reply-To: <8665687.jWqf6bo4lM@wuerfel>
References: <8665687.jWqf6bo4lM@wuerfel>
Message-ID: <20140526173401.770af4a9@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 26 May 2014 17:04:24 +0200, Arnd Bergmann wrote:
> The gpio-pch driver was recently enabled for compile-tests,
> which revealed that it is missing an include for linux/slab.h,
> which on ARM is not implied by any of the other headers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/drivers/gpio/gpio-pch.c b/drivers/gpio/gpio-pch.c
> index 83a1563..d6eac9b 100644
> --- a/drivers/gpio/gpio-pch.c
> +++ b/drivers/gpio/gpio-pch.c
> @@ -20,6 +20,7 @@
>  #include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/slab.h>
>  
>  #define PCH_EDGE_FALLING	0
>  #define PCH_EDGE_RISING		BIT(0)
> 

Good catch, thanks Arnd.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
