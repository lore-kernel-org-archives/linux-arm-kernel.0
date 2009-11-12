From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 12 Nov 2009 09:43:43 +0100
Subject: drivers/rtc/rtc-pl031.c uses __raw_readl()?
In-Reply-To: <63386a3d0911110130j2056a355l16cade8d30edb6cd@mail.gmail.com>
References: <63386a3d0911110130j2056a355l16cade8d30edb6cd@mail.gmail.com>
Message-ID: <63386a3d0911120043y2143c7f5w7289bc83b2e31847@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/11/11 Linus Walleij <linus.ml.walleij@gmail.com>:

> Is there some special reason as to why drivers/rtc/rtc-pl031.c uses
> the __raw_[read|write]l() macro instead of plain [read|write]l()?

Reading the macro definitions I come to the conclusion that readl()
is always little-endian and __raw_readl() is the machine endianness,
so that if you put your ARM in BE mode or synthesize this PrimeCell
on PPC, it will not work. PrimeCell registers are always LE I believe.

Now none of that was exactly obvious so please correct me if I'm
wrong!

I sent a patch you can slam on.

Linus Walleij
