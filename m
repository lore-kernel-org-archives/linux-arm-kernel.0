From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 13 May 2016 10:57:56 +0200
Subject: [PATCH] serial: Make SERIAL_MPS2_UART depend on ARCH_MPS2
In-Reply-To: <573591C6.1070106@arm.com>
References: <1462906570-27684-1-git-send-email-geert+renesas@glider.be>
 <573591C6.1070106@arm.com>
Message-ID: <CAMuHMdUCAyrK5hC+erph+6km8LL__3vd7Vr6SMo1N3FLN3zxHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Fri, May 13, 2016 at 10:35 AM, Vladimir Murzin
<vladimir.murzin@arm.com> wrote:
> On 10/05/16 19:56, Geert Uytterhoeven wrote:
>> Enabling support for the UART on the ARM MPS2 platform only make sense
>> when compiling for the ARM MPS2 platform, unless compile-testing.
>
> What you said is true, but looking around (see SERIAL_STM32 for example)
> I'm wondering what makes MPS2 so special flake?

Nothing. SERIAL_STM32 should be fixed, too.
I only fixed SERIAL_MPS2_UART, as it was a newly-introduced symbol.

> I was under impression that architecture/board specific guard must have
> only if we have something like
>
> #include <asm/xyz.h>
>
> or
>
> #include <mach/xyz.h>
>
> which is not a case for device-tree driven MPS2 uart.
>
> I have no idea what is practice for such things, so would be grateful to
> get it known.

That's why there's an "|| COMPILE_TEST" in the dependency.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
