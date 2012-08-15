From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 15 Aug 2012 18:34:46 +0200
Subject: [PATCH v2 04/31] arm64: MMU definitions
In-Reply-To: <201208151330.02112.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-5-git-send-email-catalin.marinas@arm.com>
 <201208151330.02112.arnd@arndb.de>
Message-ID: <CAMuHMdUEKNYFAU4N8KnJ0DPYgW7BRtaaJQSARDJCVjQOU2bFBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 3:30 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> +#define TCR_IPS_40BIT                (2 << 32)

By default, constants are int, i.e. 32-bit. So you must write

2ULL << 32

>> +#define TCR_ASID16           (1 << 36)

1ULL

> As a matter of coding style, I would much prefer tables like this to be
> written as
>
> #define TCR_IRGN_MASK           0x0000000003000300

0x0000000003000300ULL, to be safe

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
