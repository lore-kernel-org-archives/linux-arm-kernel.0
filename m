From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 05 Nov 2013 13:44:04 +0100
Subject: [PATCH 2/4] ALSA: atmel: remove dependency on <mach/gpio.h>
In-Reply-To: <1383643789-14269-1-git-send-email-linus.walleij@linaro.org>
References: <1383643789-14269-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <s5hr4avvx0r.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Tue,  5 Nov 2013 10:29:49 +0100,
Linus Walleij wrote:
> 
> This include is completely unused since the AT91 sound driver
> actually uses gpiolib properly.
> 
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ALSA SoC folks: please apply this as a fix if you wish, else
> I'd like an ACK so I can merge it in front of the dependent
> patches in the next (v3.14) merge cycle.

Thanks, I applied the patch now.


Takashi

> ---
>  sound/atmel/ac97c.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
> index ae63d22c0f88..c5f0ddd729b3 100644
> --- a/sound/atmel/ac97c.c
> +++ b/sound/atmel/ac97c.c
> @@ -34,7 +34,6 @@
>  #include <linux/dw_dmac.h>
>  
>  #include <mach/cpu.h>
> -#include <mach/gpio.h>
>  
>  #ifdef CONFIG_ARCH_AT91
>  #include <mach/hardware.h>
> -- 
> 1.8.3.1
> 
