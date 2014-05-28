From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 28 May 2014 10:42:05 +0200
Subject: [PATCH v6 1/2] clk: shmobile: r8a7779: Add clocks support
In-Reply-To: <20140528010850.GH7374@verge.net.au>
References: <1397775951-30992-1-git-send-email-horms+renesas@verge.net.au>
 <1397775951-30992-2-git-send-email-horms+renesas@verge.net.au>
 <201405271131.42301.arnd@arndb.de>
 <20140528010850.GH7374@verge.net.au>
Message-ID: <CAMuHMdVgUXOvi-Msd6qWDBVS_Wfh_5F-F7DUUMD+hhan3ReXTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, May 28, 2014 at 3:08 AM, Simon Horman <horms@verge.net.au> wrote:
>> > +#include <dt-bindings/clock/r8a7779-clock.h>
>>
>> This currently causes a build error in Linux-next, since the header file
>> has not been merged along with the driver.
>
> Hi Arnd,
>
> I'm a little unsure what combination of Kernel config options you
> are using to compile this driver in linux-next but I do agree
> that the header is missing and that would cause the compile to fail.
> I apologise for that oversight.
>
> I believe that a good fix is to add the header, which I already have queued-up
> in the renesas tree for v3.17. I wonder if Mike would consider taking
> the following patch for v3.16. Alternatively I would be happy to send
> it it to arm-soc as a fix for v3.16.

IIUIC, the only reason the driver source needs the header file is:

#define CPG_NUM_CLOCKS                  (R8A7779_CLK_OUT + 1)

Why not

#define CPG_NUM_CLOCKS                  8

and drop the include?

Or better, use "num_clks" (from of_property_count_strings(np,
"clock-output-names")), like the other R-Car drivers do.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
