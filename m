From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 26 Feb 2014 11:11:49 +0100
Subject: [PATCH] ARM: shmobile: Check r8a7791 MD21 at SMP boot
In-Reply-To: <20140226095916.15676.99394.sendpatchset@w520>
References: <20140226095916.15676.99394.sendpatchset@w520>
Message-ID: <CAMuHMdXKdN+LrhhCFKgO4=2ez0qiyc8EhtBLPzrfxmBMLpGX7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Wed, Feb 26, 2014 at 10:59 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On r8a7791 the hardware boot mode bit MD21 indicates if hardware
> debug mode is enabled or not. In case hardware debug mode is enabled
> print a warning and refrain from booting secondary CPU cores.
>
> Without this patch Koelsch with SW8-4 set to OFF will hang at SMP boot.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>

On Koelsch:

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

>  This is a reworked version of the APMU patch previously posted as
>  [PATCH] ARM: shmobile: Check MD21 at SMP boot in case of APMU

Your previous version also affected r8a7790/Lager.
Isn't this check no longer needed there? According to the Lager manual,
MD21 also enables hardware debug mode, and is also controlled by
SW8-4. Of course the CPU may behave differently, as the CPU cores
are different.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
