From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 3 Apr 2015 21:35:22 +0200
Subject: [PATCH/RFC 0/6] staging: board: armadillo800eva: Board staging
 for sh_mobile_lcdc_fb
In-Reply-To: <3984477.UtBUTfcozK@avalon>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
 <3984477.UtBUTfcozK@avalon>
Message-ID: <CAMuHMdU0tPE7Qy7YX38mvXx5KkwBmM0PNKZxa3p57M384NCr2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Fri, Apr 3, 2015 at 6:24 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Friday 03 April 2015 14:41:57 Geert Uytterhoeven wrote:
>> This RFC patch series adds board staging support for r8a7740/armadillo.
>> For now this supports only the frame buffer device for the on-board LCD.
>
> I've started adding DT support to the shmob-lcdc driver, but I have no board
> to test it on. My Armadillo is gone, and KZM9G is unusable with DT + LCDC at
> the moment as the LCDC interrupt is connected to the legacy interrupt
> controller only, not the GIC. Would you be able to test a patch set ? And if

Sure, I can test your patches on Armadillo.

> you want to implement support for the KZM9G legacy interrupt controller in DT,
> please go for it :-)

Do we need the LCDC interrupt? ;-)

Anyway, the display of my kzm9g is broken, so I never had the joy of
seeing its marvellous graphics.

>>       - sh-mobile-hdmi/sh_mobile_lcdc_fb.1 (this seems to be broken in
>>       -legacy?)
>
> HDMI is broken in legacy, we can thus drop it.

In addition, clk-r8a7740 lacks support for the non-standard register layout of
HDMICKCR.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
