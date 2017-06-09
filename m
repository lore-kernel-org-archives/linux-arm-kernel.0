From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Jun 2017 15:44:08 +0200
Subject: [PATCH] arm: aspeed: Add clock-names property to timer node
In-Reply-To: <CAK8P3a2d=T9igbhe1u3MBUF2F1TMLC7z0DQ2AmHX-LkiBAy2Ww@mail.gmail.com>
References: <20170605074846.30925-1-andrew@aj.id.au>
 <CACPK8XeM6fBztHwfrPUD+ewpMf==tBqgfj61B-k=SwT3ABTiZw@mail.gmail.com>
 <CAK8P3a2d=T9igbhe1u3MBUF2F1TMLC7z0DQ2AmHX-LkiBAy2Ww@mail.gmail.com>
Message-ID: <CACRpkdbO-g2XBf9t7+Ei9Tg-bvTfE9d1WmKyAz63BFkLrYOECw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 6, 2017 at 11:41 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jun 5, 2017 at 10:59 AM, Joel Stanley <joel@jms.id.au> wrote:
>> On Mon, Jun 5, 2017 at 5:18 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
>>> The merging of a number of clocksource drivers into fttmr010 means we
>>> require clock-names to be specified in the Aspeed timer node, else the
>>> clocksource fails to probe and boot hangs.
>>
>> Arnd,
>>
>> Linus' reworked timer driver will go into 4.13.
>>
>> Can we get this patch merged into 4.12 as a fix so we don't end up
>> with a broken boot at any stage?
>
> Hmm, can't we make the driver backward-compatible and have it fall
> back on the first clock if no clk named "PCLK" is found? Otherwise
> you still have an incompatible change in the DT binding and it will
> break if someone uses an older dtb with a newer kernel.

I was under the impression that the Aspeed support is still in its
infancy and everyone working on it using DT will recompile and
bundle the DTB as part of their kernel build at this point in time.

Are there people shipping products with DTBs on this, really?

Yours,
Linus Walleij
