From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 7 Jan 2016 20:11:37 +0100
Subject: [PATCH v3] ARM: fix atags_to_fdt with stack-protector-strong
In-Reply-To: <CAGXu5jJS1RTpwA9TRCP1y1Qm-g0OXADSb1omr_5rNFirVTovuw@mail.gmail.com>
References: <20160106233656.GA9316@www.outflux.net>
 <20160107113029.GE19062@n2100.arm.linux.org.uk>
 <CAGXu5jJS1RTpwA9TRCP1y1Qm-g0OXADSb1omr_5rNFirVTovuw@mail.gmail.com>
Message-ID: <CAMuHMdV-bHCughvYcVQfCf5wA-eS76LSeX4kPw13FZdvqQk9eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kees,

On Thu, Jan 7, 2016 at 7:40 PM, Kees Cook <keescook@chromium.org> wrote:
>> Also, I suspect that all of the decompressor should be built with
>> -fno-stack-protector as we don't have sufficient environment here.
>> Maybe it should be placed in the global CFLAGS for the decompressor?
>
> I prefer keeping it disabled in as narrow a range as possible. If
> other code gains a level of complexity that it triggers the stack
> protector code insertion, I think that's worth examining when it
> happens. If this ever becomes an actual burden, then yeah, let's do it
> for the whole decompressor, but I think it'd be best to revisit it if
> it happens again.

What's the failure mode if the stack protector code insertion is triggered?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
