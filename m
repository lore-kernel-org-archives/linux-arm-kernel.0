From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Thu, 17 May 2018 11:00:10 +0300
Subject: [PATCH 2/3] clk: renesas: r8a7795: Add ccree clock
In-Reply-To: <CAMuHMdXWPwW_p=D56BhNF274m+JLe+mbD2fqQu8-we-uMW4b8Q@mail.gmail.com>
References: <1526387370-17142-1-git-send-email-gilad@benyossef.com>
 <1526387370-17142-3-git-send-email-gilad@benyossef.com>
 <CAMuHMdXWPwW_p=D56BhNF274m+JLe+mbD2fqQu8-we-uMW4b8Q@mail.gmail.com>
Message-ID: <CAOtvUMf0pnX1+MOz0KkB5LxqL5HTmLRYjVZTUrAx-eCvm26+LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 5:47 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Gilad,
>
> On Tue, May 15, 2018 at 2:29 PM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
>> This patch adds the clock used by the CryptoCell 630p instance in the SoC.
>>
>> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>
> Thanks for your patch!
>
>> --- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
>> +++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
>> @@ -132,6 +132,7 @@ static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
>>         DEF_MOD("sys-dmac2",             217,   R8A7795_CLK_S0D3),
>>         DEF_MOD("sys-dmac1",             218,   R8A7795_CLK_S0D3),
>>         DEF_MOD("sys-dmac0",             219,   R8A7795_CLK_S0D3),
>> +       DEF_MOD("ccree",                 229,   R8A7795_CLK_S3D2),
>
> I don't know if "ccree" is the proper name for this clock, as there
> may be multiple
> instances.

I'd be happy to rename it to anything else. Suggestions?

> I also can't verify the parent clock.

I'm afraid I can't really help. This is based on code snippet from
Renesas. I verified it works but
I am not an expert on the clock settings :-(

>
>>         DEF_MOD("cmt3",                  300,   R8A7795_CLK_R),
>>         DEF_MOD("cmt2",                  301,   R8A7795_CLK_R),
>>         DEF_MOD("cmt1",                  302,   R8A7795_CLK_R),
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
