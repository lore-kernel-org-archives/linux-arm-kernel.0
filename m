From: tiffang@gmail.com (ikjn)
Date: Thu, 22 Jul 2010 10:12:37 +0900
Subject: Question about armv7(cortex-a9) dcache initialization.
Message-ID: <AANLkTilpM7DcP26kvAmtukre16alx72Rh9CcnTvWVMD5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the ARM Cortex-A9 TRM, I found a note in chapter 6.1

Note:
You must invalidate the instruction cache, the data cache, and BTAC
before using them.
You are not required to invalidate the main TLB, even though it is
recommended for
safety reasons. This ensures compatibility with future revisions of
the processor.

But the kernel does.. ( __v7_setup in proc-v7.S )
clean & invalidate before turning on the MMU, not just 'invalidate'.

If dcache tag&data ram has garbage data when power up,
I think some dirty data lines can be flushed into to L2 or L3 memory
because kernel does clean.
And It can pollute the memory.

Is it possible in cortex-A9?

Thanks..
