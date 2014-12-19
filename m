From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 19 Dec 2014 17:53:44 +0300
Subject: [PATCH] ALSA: atmel: fix building the ac97 driver for
 at91-multiplatform
In-Reply-To: <1418944390-27719-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1418944390-27719-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <54943BF8.4050008@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/19/2014 2:13 AM, Alexandre Belloni wrote:

> From: Arnd Bergmann <arnd@arndb.de>

> at91 will no longer export the mach/cpu.h and mach/hardware.h header files
> in the future, which would break building the atmel ac97c driver.

> Since the cpu_is_* check is only used to find out whether we are running
> on avr32 or arm/at91, we can hardcode that check in the ARM case.

> Unfortunately the driver is missing other work to be useful again on ARM,
> if anyone wants to actually use it, they need to add a DT binding, and
> the driver should really be converted to use the ASoC framework.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Link: http://www.spinics.net/lists/arm-kernel/msg382068.html
> ---
>   sound/atmel/ac97c.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

> diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
> index b59427d5a697..83975f8d5947 100644
> --- a/sound/atmel/ac97c.c
> +++ b/sound/atmel/ac97c.c
> @@ -34,10 +34,10 @@
>   #include <linux/platform_data/dma-dw.h>
>   #include <linux/dma/dw.h>
>
> +#ifdef CONFIG_AVR32
>   #include <mach/cpu.h>
> -
> -#ifdef CONFIG_ARCH_AT91
> -#include <mach/hardware.h>
> +#else
> +#define cpu_is_at32ap7000() (0)

    () around 0 not needed at all.

[...]

WBR, Sergei
