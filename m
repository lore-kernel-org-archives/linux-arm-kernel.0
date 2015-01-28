From: tiwai@suse.de (Takashi Iwai)
Date: Wed, 28 Jan 2015 15:56:39 +0100
Subject: [PATCH] sound: sscape: add missing include of asm/io.h
In-Reply-To: <7794866.XZSLAdxcrb@wuerfel>
References: <7794866.XZSLAdxcrb@wuerfel>
Message-ID: <s5hlhknx8bc.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Wed, 28 Jan 2015 15:54:04 +0100,
Arnd Bergmann wrote:
> 
> The soundscape driver uses the ISA inb/outb functions declared
> in asm/io.h, so it needs to include this header to avoid
> a build error:
> 
> sscape.c: In function 'sscape_write_unsafe':
> sscape.c:203:2: error: implicit declaration of function 'outb' [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Could you correct asm/io.h with linux/io.h in subject and description
to match with the actual change?


thanks,

Takashi

> 
> diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
> index 018ab140c2be..7b248cdf06e2 100644
> --- a/sound/isa/sscape.c
> +++ b/sound/isa/sscape.c
> @@ -23,6 +23,7 @@
>  
>  #include <linux/init.h>
>  #include <linux/err.h>
> +#include <linux/io.h>
>  #include <linux/isa.h>
>  #include <linux/delay.h>
>  #include <linux/firmware.h>
> 
