From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 6 Mar 2014 14:21:56 +0100
Subject: [PATCH V2 01/12] clk: shmobile: add CPG driver for rz-platforms
In-Reply-To: <20140306130655.GA10657@katana>
References: <1394105552-9744-1-git-send-email-wsa@the-dreams.de>
 <1394105552-9744-2-git-send-email-wsa@the-dreams.de>
 <1434755.d9svPEINg5@avalon> <20140306130655.GA10657@katana>
Message-ID: <CAMuHMdXKSWosrojJ--BiHOMx5fZwZutOiWjZ_P3k83wgNLqXxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Thu, Mar 6, 2014 at 2:06 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> > +   num_clks = of_property_count_strings(np, "clock-output-names");
>> > +   if (WARN(num_clks <= 0, "can't count CPG clocks\n"))
>> > +           goto out;
>>
>> You can return directly instead of goto out.
>
> I personally don't prefer the mixture of goto and direct return. Please
> say if you insist on that.

Here it's not really a mix: there is a strict separation between cases where
cleanup/error handling is done and case where it's not.
So it serves as a clue for the reader, who doesn't have to scroll down to see
that no cleanup/error handling is done later.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
