From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 28 Apr 2014 17:03:48 +0200
Subject: [PATCH] clk: shmobile: clk-mstp: change to using clock-indices
In-Reply-To: <20140428132641.GA9590@katana>
References: <1397577994-12061-1-git-send-email-ben.dooks@codethink.co.uk>
 <20140428132641.GA9590@katana>
Message-ID: <CAMuHMdUmSj6FPhDLazoXxZD_nasL_A0NE1_h63+53b9sNHer2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Mon, Apr 28, 2014 at 3:26 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> +     if (of_find_property(np, "clock-indices", &i))
>> +             idxname = "clock-indices";
>> +     else
>> +             idxname = "renesas,clock-indices";
>
> ...and here in the code? It might also be a tad more intuitive to check

Thanks, a comment never hurts.

> for the depracted binding, and if not found, use the new one as default,
> i.e. switch the logic of the if block. Very minor nit, though.

I think checking for the new one first is the right thing to do.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus TorvaldsH
