From: rabin@rab.in (Rabin Vincent)
Date: Wed, 24 Feb 2010 01:33:30 +0530
Subject: sleeping clk_[enable,disable]?
In-Reply-To: <63386a3d1002230632v4c98c79dg4512684f76008a7d@mail.gmail.com>
References: <63386a3d1002230632v4c98c79dg4512684f76008a7d@mail.gmail.com>
Message-ID: <20100223200329.GC6325@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2010 at 03:32:19PM +0100, Linus Walleij wrote:
> * Throw in udelay():s after the clk_[enable,disable] calls, with some values
>   that are unfortunately then spread out in the drivers instead of in the
>   clk implementation.

Or you could place the udelay()s inside the clk_* calls themselves.  See
mach-pxa/clock.c or plat-stmp3xxx/clock.c.

Rabin
