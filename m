From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 23 Feb 2010 22:36:40 +0100
Subject: sleeping clk_[enable,disable]?
In-Reply-To: <20100223200329.GC6325@debian>
References: <63386a3d1002230632v4c98c79dg4512684f76008a7d@mail.gmail.com>
	<20100223200329.GC6325@debian>
Message-ID: <63386a3d1002231336n160d9419if6c339d57ab1512@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/2/23 Rabin Vincent <rabin@rab.in>:

> On Tue, Feb 23, 2010 at 03:32:19PM +0100, Linus Walleij wrote:

>> * Throw in udelay():s after the clk_[enable,disable] calls, with some values
>> ? that are unfortunately then spread out in the drivers instead of in the
>> ? clk implementation.
>
> Or you could place the udelay()s inside the clk_* calls themselves. ?See
> mach-pxa/clock.c or plat-stmp3xxx/clock.c.

Hm, yeah pxa has a the maximum defined delay 5 us, and stmp3xx has
a maximum of 10 us both probably acceptable delays in a fastpath. So your
system latency requirements control the limit here and in that case ...
perhaps one would better just switch all interrupt handlers where a
clk_enable/disable occurs to threaded anyway just to be on the safe
side. (Just thinking aloud a bit...)

Yours,
Linus Walleij
