From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Apr 2012 12:34:25 +0100
Subject: [PATCH 5/9 v2] gpio/nomadik: use ioremap() instead of static
 mappings
In-Reply-To: <1335180632-21381-1-git-send-email-linus.walleij@stericsson.com>
References: <1335180632-21381-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120423113425.GN24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 01:30:32PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> We were using a custom io_p2v() (physical-to-virtual) translation
> macro, but it's fully possible to just ioremap() this memory
> now, so skip use of static addresses altogether.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpio/gpio-nomadik.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
> index 7b45d88..bddc3dd 100644
> --- a/drivers/gpio/gpio-nomadik.c
> +++ b/drivers/gpio/gpio-nomadik.c
> @@ -28,7 +28,6 @@
>  
>  #include <plat/pincfg.h>
>  #include <plat/gpio-nomadik.h>
> -#include <mach/hardware.h>
>  #include <asm/gpio.h>

While you're here, please replace this with linux/gpio.h - which will give
us one less direct dependency on asm/ or mach/ includes from drivers.
