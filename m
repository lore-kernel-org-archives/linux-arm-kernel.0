From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 26 Apr 2016 08:41:40 +0200
Subject: [PATCH 0/6] arm64/ARM: dts: renesas: Don't disable referenced
 optional clocks
In-Reply-To: <20160426035220.GA27086@verge.net.au>
References: <1461593315-21307-1-git-send-email-geert+renesas@glider.be>
 <20160426035220.GA27086@verge.net.au>
Message-ID: <CAMuHMdUUVBLP4RrX_j6EP_kUUbFue_T+5GEJog7Hdo5e2+fM=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, Apr 26, 2016 at 5:52 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Apr 25, 2016 at 04:08:29PM +0200, Geert Uytterhoeven wrote:
>> clk_get() on a disabled clock node will return -EPROBE_DEFER, which can
>> cause drivers to be deferred forever if such clocks are referenced in
>> their devices' clocks properties. Disabled clock nodes show this
>> behavior as of commit 3e5dd6f6e690048d ("clk: Ignore disabled DT clock
>> providers"), which is in v4.6-rc1.
>>
>> Commit ac6908b3049397b1 ("ARM: dts: r8a7791: Don't disable referenced
>> optional clocks") fixed this for the Porter development board, which
>> doesn't have the SCIF_CLK crystal populated.  This patch series fixes
>> the same problem for the remaining Renesas DTSes, by updating disabled
>> external clock nodes to default to a frequency of 0, but not disabling
>> them.
>>
>> None of these should show up with in-tree supported boards, but J?rg
>> Billeter <j@bitron.ch> reported seeing the problem with v4.6-rc5 on a
>> custom R-Car H3 board. Hence you may want to queue at least the arm64
>> fix for v4.6.

> I have tentatively done the following:
>
> * Queued up the portion of the arm64 patch that is relevant to v4.6
>   (i.e. changes DT nodes that exist in v4.6) as a fix for v4.6.
> * Queued up the rest for v4.7

Thanks!

> Please check that what is in renesas-next-20160426-v4.6-rc1 looks sensible.

Looks all good to me...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
