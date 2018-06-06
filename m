From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 6 Jun 2018 11:28:51 +0200
Subject: [PATCH] ARM: Build secure_cntvoff.S unconditionally to fix
 shmobile !SMP build
In-Reply-To: <20180606092725.GX17671@n2100.armlinux.org.uk>
References: <1528275154-5164-1-git-send-email-geert+renesas@glider.be>
 <20180606090953.GW17671@n2100.armlinux.org.uk>
 <CAMuHMdVq0Mwui6jrnX4sd2=L+p3Ta4qM2PxQ2HLQ0btajTV6hw@mail.gmail.com>
 <20180606092725.GX17671@n2100.armlinux.org.uk>
Message-ID: <CAMuHMdUC-B9KLjioUvANzd0U0fMiy+48+zBHvZg=nX+o69RvEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Jun 6, 2018 at 11:27 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Jun 06, 2018 at 11:22:41AM +0200, Geert Uytterhoeven wrote:
>> On Wed, Jun 6, 2018 at 11:09 AM, Russell King - ARM Linux
>> <linux@armlinux.org.uk> wrote:
>> >> Fixes: cad160ed0a94927e ("ARM: shmobile: Convert file to use cntvoff")
>> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> >
>> > This doesn't look right to me, but I don't have secure_cntvoff in any
>> > tree here that I can look at to check.  What if secure_cntvoff contains
>> > instructions only available on ARMv7 CPUs, and not ARMv4?
>>
>> Compiled != called.
>
> That makes little difference when the assembler validates that the
> instructions are possible on the target architecture and errors out
> if not.

The file does have ".arch armv7-a".

> That's why I qualified my reply by saying that I didn't have the
> contents of secure_cntvoff to reference - there's no clue whether
> it's a .c or .S file from just this patch, and there's no visibility
> what it contains.

https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/commit/?id=7c607944bc657616
https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/commit/?id=cad160ed0a94927e

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
