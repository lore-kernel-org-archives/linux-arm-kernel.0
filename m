From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 11 Apr 2016 09:24:54 +0200
Subject: [PATCH v4 11/11] soc: renesas: rcar-sysc: Add support for R-Car
 H3 power areas
In-Reply-To: <1469037.GP7ci3FqN3@avalon>
References: <1460031628-13336-1-git-send-email-geert+renesas@glider.be>
 <1460031628-13336-12-git-send-email-geert+renesas@glider.be>
 <1469037.GP7ci3FqN3@avalon>
Message-ID: <CAMuHMdU7pEkbMBmFmJ_X7iqrk-mjXFsXSYSRZJQgBYR_KS5Hhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 9, 2016 at 9:22 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- /dev/null
>> +++ b/drivers/soc/renesas/r8a7795-sysc.c
>> @@ -0,0 +1,53 @@
>> +/*
>> + * Renesas R-Car H3 System Controller
>> + *
>> + * Copyright (C) 2016 Glider bvba
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; version 2 of the License.
>> + */
>> +
>> +#include <linux/bug.h>
>
> Why do you need this header ? ARRAY_SIZE is defined in linux/kernel.h and
> __initconst in linux/init.h. Am I missing something ?

ARRAY_SIZE() uses __must_be_array() uses BUILD_BUG_ON_ZERO().

IIRC, I sent a patch to include bug.h a while ago, but it was rejected.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
