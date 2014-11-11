From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 11 Nov 2014 20:00:26 +0100
Subject: [PATCH 3/4] ARM: shmobile: rcar-gen2: Add CA7 arch_timer
 initialization for r8a7794
In-Reply-To: <5583214.HuX5EZ5Unx@wuerfel>
References: <cover.1415058939.git.horms+renesas@verge.net.au>
 <9ce3fa6816c2fb59d128248c9b0509aef1c5dae7.1415058939.git.horms+renesas@verge.net.au>
 <5583214.HuX5EZ5Unx@wuerfel>
Message-ID: <CAMuHMdUek9RA-tpVJbXKx1MENk47-E2s+437+SYNR9KbaO62dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 7:27 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 04 November 2014 10:50:08 Simon Horman wrote:
>> From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>>
>> On E2, the arch timer is hooked up to a different clock, and the CA7's arch
>> timer CNTVOFF register must be initialized.
>>
>> Based on work by Hisashi Nakamura.
>>
>> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> This is one of the patches that broke allmodconfig in linux-next.
>
> Can you apply the patch below before sending it to arm-soc?
>
> Thanks,
>
>         Arnd
>
> ---
> From 8bf0a4cae3137411498ff23ca46f693e4c22a25b Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Tue, 11 Nov 2014 16:36:50 +0100
> Subject: [PATCH] ARM: shmobile: always build rcar setup for armv7
>
> In a combined ARMv6/v7 kernel, the setup-rcar-gen2.c cannot
> currently be compiled correctly because it uses the isb
> instruction that is not available on ARMv6. Adding the
> -march=armv7-a flag lets the compiler know that it is safe
> to build this file for ARMv7.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, this is a better solution than "[RFT] ARM: shmobile: rcar-gen2:
Fix build breakage" (https://lkml.org/lkml/2014/10/31/338).

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
