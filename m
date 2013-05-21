From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 21 May 2013 08:57:36 +0200
Subject: [PATCH] arm64: kernel: need extern variable 'screen_info' for
 related driver using.
In-Reply-To: <519AE6D7.1090401@asianux.com>
References: <5199B7D6.40907@asianux.com>
 <20130520091008.GB31359@mudshark.cambridge.arm.com>
 <519AE6D7.1090401@asianux.com>
Message-ID: <CAMuHMdWNHPDkf35MYMKnxt5pn3a+dsT4jgYxuuHrp+mpZMckfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 21, 2013 at 5:15 AM, Chen Gang <gang.chen@asianux.com> wrote:
>> I think it would be better if we added a something like
>> CONFIG_HAVE_VGA_CONSOLE, which VGA_CONSOLE can then depend on. Architectures
>> like x86 can then select the former, and we can remove the long list of
>> architectures from the current option.
>
> I guess your meaning is:
>
>   under arm64, actually, need not support 'VGA_CONSOLE', and 'screen_info' is useless.
>   So better to define 'CONFIG_HAVE_VGA_CONSOLE' which 'VGA_CONSOLE' can depend on it, and in arm64, we do not define CONFIG_HAVE_VGA_CONSOLE.
>
> Is it correct ?

No, you missed "and we can remove the long list of architectures from the
current option".

> If so, I recommend to add depend item for VGA_CONSOLE directly:

I strongly support CONFIG_HAVE_VGA_CONSOLE.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
