From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 18 Jul 2013 10:02:27 +0200
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <51E72752.9020206@zytor.com>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <20130716004727.b60b2c96.akpm@linux-foundation.org>
 <20130716005611.e4ccab02.akpm@linux-foundation.org>
 <201307161008.07643.yann.morin.1998@free.fr>
 <20130716180408.GA19863@merkur.ravnborg.org>
 <20130717211649.GA5619@merkur.ravnborg.org>
 <20130717223033.GF3385@free.fr> <51E72752.9020206@zytor.com>
Message-ID: <CAMuHMdVo3rnTtXUZOZavdjJ4uHv4KYPA5g1Py6GTdZD3dPwFzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 1:22 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> It is worth noting that one of the things that keep getting brought up
> as something that need this is gcc/binutils support for a specific feature.

Yeah, then those tests would be run only once, at kconfig time. I guess we
still run some of them many times, due to the use of recursive make?

Note that these will end up in your .config --- which is not necesarily a bad
thing --- but it does mean that if e.g. you sent me your .config,
several options
may change when I try to use it.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
