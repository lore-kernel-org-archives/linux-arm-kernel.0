From: tiwai@suse.de (Takashi Iwai)
Date: Wed, 28 Jan 2015 16:28:13 +0100
Subject: [PATCH] sound: sscape: add missing include of linux/io.h
In-Reply-To: <3560329.35JVsOOFlQ@wuerfel>
References: <7794866.XZSLAdxcrb@wuerfel> <s5hlhknx8bc.wl-tiwai@suse.de>
 <3560329.35JVsOOFlQ@wuerfel>
Message-ID: <s5hiofqylf6.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Wed, 28 Jan 2015 16:04:46 +0100,
Arnd Bergmann wrote:
> 
> The soundscape driver uses the ISA inb/outb functions declared
> in linux/io.h, so it needs to include this header to avoid
> a build error:
> 
> sscape.c: In function 'sscape_write_unsafe':
> sscape.c:203:2: error: implicit declaration of function 'outb' [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Sorry about messing up the patch description the first time. I'm cleaning
> out old patches from a randconfig build tree and I found this one was
> still needed but did not inspect the changelog closely enough.

Thanks, applied.


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
