From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 22 May 2018 09:48:06 +0200
Subject: [PATCH 3/3] arm64: dts: renesas: r8a7795: add ccree binding
In-Reply-To: <CAOtvUMcf-fHduThORv3cbcN16wEm_Si27OjSjAmSc9g5eK4PJw@mail.gmail.com>
References: <1526387370-17142-1-git-send-email-gilad@benyossef.com>
 <1526387370-17142-4-git-send-email-gilad@benyossef.com>
 <CAMuHMdWzeNqsho1V6ezZb81T3_HcRzrtuQpmGXsjtFgt9BtZDQ@mail.gmail.com>
 <20180516074333.i2672u435ymwffk3@verge.net.au>
 <CAOtvUMfFjokOLCg6aHNQESJ_q4Jiok3izrPtae5wR+cND=XL6g@mail.gmail.com>
 <CAMuHMdVM55S7+PdnKusX-qkTxioc=0kQ6EGSbwv+kbLk5RCUYw@mail.gmail.com>
 <CAOtvUMcf-fHduThORv3cbcN16wEm_Si27OjSjAmSc9g5eK4PJw@mail.gmail.com>
Message-ID: <CAMuHMdX-t8WfjRKpZ7UxXBbBNojsn-8z7_BM9grmLJcf=9Ks2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gilad,

On Mon, May 21, 2018 at 3:43 PM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> On Thu, May 17, 2018 at 1:16 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> Indeed. From a quick glance, it looks like drivers/crypto/ccree/cc_driver.c
>> does not distinguish between the absence of the clock property, and an
>> actual error in getting the clock, and never considers any error a failure
>> (incl. -PROBE_DEFER).
>>
>> As of_clk_get() returns -ENOENT for both a missing clock property and a
>> missing clock, you should use (devm_)clk_get() instead, and distinguish
>> between NULL (no clock property) and IS_ERR() (actual failure -> abort).
>
> I was trying to do as you suggested but I didn't quite get what is the
> dev_id (2nd) parameter to devm_clk_get parameter is supposed to be.

It's the (optional) name of the clock, helpful in case there is more than one.
In your case, NULL is fine.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
