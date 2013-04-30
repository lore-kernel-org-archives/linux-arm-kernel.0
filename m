From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 30 Apr 2013 11:39:05 +0200
Subject: linux-next build error (at91) - use of bool in mach/arch.h
In-Reply-To: <517F8FF4.3050901@atmel.com>
References: <517F8FF4.3050901@atmel.com>
Message-ID: <CAMuHMdXYaDHYq7CG8ftP+yyF18pMx8qZrvM3AUTAXk+tUruNcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 30, 2013 at 11:33 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> So, I am wondering if the best correction is to add the types.h header file
> in the asm/mach/arch.h file, like this:
>
> --- a/arch/arm/include/asm/mach/arch.h
> +++ b/arch/arm/include/asm/mach/arch.h
> @@ -8,6 +8,8 @@
>   * published by the Free Software Foundation.
>   */
>
> +#include <linux/types.h>
> +
>  #ifndef __ASSEMBLY__
>
>  struct tag;
>
> or if a better option would be to re-arrange the include directives in
> various at91xxx_devices.c files?

Include files should be self-contained, so asm/mach/arch.h is the right place.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
