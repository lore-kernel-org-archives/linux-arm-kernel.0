From: ak@linux.intel.com (Andi Kleen)
Date: Sat, 1 Mar 2014 08:12:58 -0800
Subject: static asmlinkage in irqchip (was Re: next build: 78 warnings 0
 failures (next/next-20140228))
In-Reply-To: <5311449E.90902@codeaurora.org>
References: <5310415c.2d79420a.3275.ffff92bb@mx.google.com>
 <5311449E.90902@codeaurora.org>
Message-ID: <20140301161258.GN12219@tassilo.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> These seem to be caused by 128ea04a9885 (lto: Make asmlinkage __visible,
> 2014-02-08). Before that change asmlinkage was defined to nothing on
> ARM, but now it's __visible. Should we just drop asmlinkage here?

These functions are just called by the generic C interrupt layer right?
Yes should just drop asmlinkage. It doesn't make any sense to mark
functions that only called from C asmlinkage.

Patch looks good to me.

-Andi
