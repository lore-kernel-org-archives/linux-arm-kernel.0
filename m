From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 9 May 2014 19:20:41 +0200
Subject: [RFC][PATCH 6/8] sched,idle: Avoid spurious wakeup IPIs
In-Reply-To: <20140509170946.GN7950@arm.com>
References: <20140411134243.160989490@infradead.org>
 <20140411135218.478299389@infradead.org>
 <CAAG0J9_q1KsUx10-XAb7AJnxv2ehctg6q1KME7ahsk1OZV8vZQ@mail.gmail.com>
 <20140509141520.GV2844@laptop.programming.kicks-ass.net>
 <20140509144034.GF7950@arm.com>
 <20140509145002.GW2844@laptop.programming.kicks-ass.net>
 <20140509145745.GI7950@arm.com>
 <20140509170234.GZ30445@twins.programming.kicks-ass.net>
 <20140509170649.GG13658@twins.programming.kicks-ass.net>
 <20140509170946.GN7950@arm.com>
Message-ID: <20140509172041.GB30445@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 06:09:46PM +0100, Catalin Marinas wrote:
> On Fri, May 09, 2014 at 06:06:49PM +0100, Peter Zijlstra wrote:
> > Subject: arm64: Remove TIF_POLLING_NRFLAG
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Fri May  9 19:04:00 CEST 2014
> > 
> > The only idle method for arm64 is WFI and it therefore
> > unconditionally requires the reschedule interrupt when idle.
> > 
> > Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> 
> There's a tag with my name already but just in case you need another:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

The more the merrier :-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/94428b58/attachment.sig>
