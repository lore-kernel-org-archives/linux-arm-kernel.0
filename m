From: joshc@codeaurora.org (Josh Cartwright)
Date: Mon, 3 Mar 2014 14:21:46 -0600
Subject: static asmlinkage in irqchip (was Re: next build: 78 warnings 0
 failures (next/next-20140228))
In-Reply-To: <20140303190658.GO12219@tassilo.jf.intel.com>
References: <5310415c.2d79420a.3275.ffff92bb@mx.google.com>
 <5311449E.90902@codeaurora.org>
 <20140301161258.GN12219@tassilo.jf.intel.com>
 <20140303161217.GK7308@joshc.qualcomm.com>
 <20140303190658.GO12219@tassilo.jf.intel.com>
Message-ID: <20140303202146.GB28282@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 11:06:58AM -0800, Andi Kleen wrote:
> On Mon, Mar 03, 2014 at 10:12:17AM -0600, Josh Cartwright wrote:
> > On Sat, Mar 01, 2014 at 08:12:58AM -0800, Andi Kleen wrote:
> > > > These seem to be caused by 128ea04a9885 (lto: Make asmlinkage __visible,
> > > > 2014-02-08). Before that change asmlinkage was defined to nothing on
> > > > ARM, but now it's __visible. Should we just drop asmlinkage here?
> > >
> > > These functions are just called by the generic C interrupt layer right?
> > > Yes should just drop asmlinkage. It doesn't make any sense to mark
> > > functions that only called from C asmlinkage.
> > 
> > On ARM[64], these functions are called from assembly indirectly through
> > the 'handle_arch_irq' function pointer, so I don't think it makes sense
> > to drop 'asmlinkage'.
> 
> So do you do anything special in asmlinkage? If not it won't make
> any difference for you.

As Russell elaborated, ARM doesn't have the special calling convention
magic that x86 does, so it should be safe to remove.

Sorry for the noise,
  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
