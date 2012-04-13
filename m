From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Apr 2012 14:30:57 +0200
Subject: linux-next: "amba: Remove AMBA level regulator support" commit.
In-Reply-To: <20120413103207.GL24211@n2100.arm.linux.org.uk>
References: <20120413012230.GA30438@windriver.com>
 <CAAQ0ZWReL=+bm9UOnt2=Dfy0zeWbJe3=y3pPzUKRzm2y277kFQ@mail.gmail.com>
 <20120413103207.GL24211@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYfRVkUqhuNw3iwHNFZJwG=2MAqtzZyK6qytFOzqUrosQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 12:32 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 13, 2012 at 10:01:52AM +0800, Shawn Guo wrote:
>> That's because Mark's patch removes "#include
>> <linux/regulator/consumer.h>" included indirectly by
>> drivers/dma/ste_dma40.c from linux/amba/bus.h. ?The ste_dma40.c should
>> really directly includes consumer.h.
>
> Okay, I'll drop this patch because it's causing regressions, so it can't
> be pushed as a 'fix' during -rc.

Actually *not* having Marks patch also causes a regression on Ux500,
albeit not at compile time, but at runtime.

So for me as ux500 maintainer it's perfectly OK to have compilation
broken until that DMA patch arrives (should just be an issue of the
DMA maintainer picking it up), but if others feel differently
by all means hold it off until the other one arrives.

Yours,
Linus Walleij
