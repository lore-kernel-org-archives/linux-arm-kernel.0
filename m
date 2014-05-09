From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 9 May 2014 19:02:34 +0200
Subject: [RFC][PATCH 6/8] sched,idle: Avoid spurious wakeup IPIs
In-Reply-To: <20140509145745.GI7950@arm.com>
References: <20140411134243.160989490@infradead.org>
 <20140411135218.478299389@infradead.org>
 <CAAG0J9_q1KsUx10-XAb7AJnxv2ehctg6q1KME7ahsk1OZV8vZQ@mail.gmail.com>
 <20140509141520.GV2844@laptop.programming.kicks-ass.net>
 <20140509144034.GF7950@arm.com>
 <20140509145002.GW2844@laptop.programming.kicks-ass.net>
 <20140509145745.GI7950@arm.com>
Message-ID: <20140509170234.GZ30445@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 03:57:45PM +0100, Catalin Marinas wrote:
> On Fri, May 09, 2014 at 03:50:02PM +0100, Peter Zijlstra wrote:
> > On Fri, May 09, 2014 at 03:40:34PM +0100, Catalin Marinas wrote:
> > 
> > > I wonder why we still need TIF_POLLING_NRFLAG for arm64. It was on arm
> > > until commit 16a8016372c42c7628eb (sanitize tsk_is_polling()). On arm64
> > > we use wfi for idle or a firmware call but in both cases the assumption
> > > is that we need an interrupt for waking up.
> > > 
> > > So I think we should remove this macro for arm64.
> > 
> > Does ARM64 support idle=poll? If so, you could keep it for that,
> > otherwise it does indeed appear to be pointless.
> 
> We don't support idle=poll either.
> 
> > As to 32bit ARM, are there SMP chips which do not have WFI?
> 
> No. WFI is even used for the secondary booting protocol (we need to send
> an IPI to get them going).

OK, so I'll queue a patch removing TIF_POLLING_NRFLAG for arm64.

Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/410edcd6/attachment.sig>
