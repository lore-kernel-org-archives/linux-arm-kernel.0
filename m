From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 2 Mar 2014 12:51:51 +0100
Subject: [PATCH v3 01/20] clk: shmobile: r8a7779: Add clocks support
In-Reply-To: <3584854.kj2ZbTBvnM@avalon>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-2-git-send-email-horms+renesas@verge.net.au>
 <20140301135002.GA4307@katana> <3584854.kj2ZbTBvnM@avalon>
Message-ID: <CAMuHMdWE4jpQY32BvD8FyZD=LMtAAXZkMG=KR6usLoO4N7Qrjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 2, 2014 at 12:35 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Saturday 01 March 2014 14:50:03 Wolfram Sang wrote:
>> > +   cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
>> > +   clks = kzalloc(CPG_NUM_CLOCKS * sizeof(*clks), GFP_KERNEL);
>> > +   if (cpg == NULL || clks == NULL) {
>> > +           /* We're leaking memory on purpose, there's no point in cleaning
>> > +            * up as the system won't boot anyway.
>> > +            */
>> > +           pr_err("%s: failed to allocate cpg\n", __func__);
>> > +           return;
>> > +   }
>>
>> I have problems with this sloppiness. Writing the comment took probably
>> the same time as writing the proper exit path :) On the drawback side,
>> static code checkers will keep reporting this.
>
> Then static code checkers should be fixed :-) or at least provide an override.
> Given that the system won't boot if this fails I don't see a point in adding
> useless code to the kernel that would just result in a larger binary size.

If binary size is what matters, I think you can remove the pr_err(), too,
as the kzalloc() above will scream, won't it?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
