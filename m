From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Aug 2011 16:05:01 +0200
Subject: PB1176 broken in -rc1
In-Reply-To: <20110810152400.GO10121@e102144-lin.cambridge.arm.com>
References: <20110810152400.GO10121@e102144-lin.cambridge.arm.com>
Message-ID: <CACRpkdZs=PuFNfHTiviF-vXaz2_-w8g-ZsMw6_mhozbZ8a3r7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 5:24 PM, Will Deacon <will.deacon@arm.com> wrote:

> [ ? ?0.000000] CPU: found DTCM0 4k @ 00000000, not enabled
> [ ? ?0.000000] CPU: moved DTCM0 4k to fffe8000, enabled
> [ ? ?0.000000] CPU: found DTCM1 4k @ 00000000, not enabled
> [ ? ?0.000000] CPU: moved DTCM1 4k to fffe9000, enabled
> [ ? ?0.000000] CPU: found ITCM0 4k @ 00000000, not enabled
> [ ? ?0.000000] CPU: moved ITCM0 4k to fffe0000, enabled
> [ ? ?0.000000] CPU: found ITCM1 4k @ 00000000, not enabled
> [ ? ?0.000000] CPU: moved ITCM1 4k to fffe1000, enabled

Just hijacking the thread: at one time I think I saw some ARM
high-level schematic of a mpcore where the ARM cores actually had
TCM in them.

I actually spent some time adding multicore TCM support until
I realized that the PB11MPcore actually didn't have TCM.
So I just dropped that stuff.

But to be sure, is there a platform like that, multicore, with
per-processor TCM?

Thanks,
Linus Walleij
