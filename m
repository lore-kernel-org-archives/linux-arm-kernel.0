From: tiwai@suse.de (Takashi Iwai)
Date: Thu, 25 Dec 2014 11:19:04 +0100
Subject: [PATCH v2] ALSA: atmel: fix building the ac97 driver for
 at91-multiplatform
In-Reply-To: <1419160689-20447-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1419160689-20447-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <s5hppb8hw13.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Sun, 21 Dec 2014 12:18:09 +0100,
Alexandre Belloni wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> at91 will no longer export the mach/cpu.h and mach/hardware.h header files
> in the future, which would break building the atmel ac97c driver.
> 
> Since the cpu_is_* check is only used to find out whether we are running
> on avr32 or arm/at91, we can hardcode that check in the ARM case.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Link: http://www.spinics.net/lists/arm-kernel/msg382068.html

Is this targeted for 3.19 or 3.20?


thanks,

Takashi

> ---
>  sound/atmel/ac97c.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
> index b59427d5a697..83975f8d5947 100644
> --- a/sound/atmel/ac97c.c
> +++ b/sound/atmel/ac97c.c
> @@ -34,10 +34,10 @@
>  #include <linux/platform_data/dma-dw.h>
>  #include <linux/dma/dw.h>
>  
> +#ifdef CONFIG_AVR32
>  #include <mach/cpu.h>
> -
> -#ifdef CONFIG_ARCH_AT91
> -#include <mach/hardware.h>
> +#else
> +#define cpu_is_at32ap7000() 0
>  #endif
>  
>  #include "ac97c.h"
> -- 
> 2.1.0
> 
