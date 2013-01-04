From: pkluba@dension.com (Patrik, Kluba)
Date: Fri, 4 Jan 2013 08:48:50 +0100
Subject: [PATCH 01/01] arm: fix a preempt_count() corruption for
 CONFIG_PREEMPT=n
In-Reply-To: <50E4D39C.1030001@codeaurora.org>
References: <20121215085129.71d203b2.pkluba@dension.com>
 <50D10224.30600@codeaurora.org>
 <20121219000139.GV14363@n2100.arm.linux.org.uk>
 <50E4D39C.1030001@codeaurora.org>
Message-ID: <20130104084850.4553bc6f.pkluba@dension.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 02 Jan 2013 16:41:00 -0800
Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 12/18/12 16:01, Russell King - ARM Linux wrote:
> > On Tue, Dec 18, 2012 at 03:54:12PM -0800, Stephen Boyd wrote:
> >> Can you try this patch? I'll probably send a follow up patch that
> >> consolidates the duplicated preempt_decrement code into some
> >> assembly macro. We may also want to fix it up so that assembly
> >> stubs call into the preempt tracer. I'm not sure how that works
> >> right now with VFP.
> > This looks like a sensible fix to me - once tested of course.
> 
> Kluba, did the patch work for you?
> 

Sorry for being late, was on holiday. Yes, you were right,
CONFIG_DEBUG_PREEMPT (after breaking dependency on CONFIG_PREEMPT -
this is how I caught the exact place) and CONFIG_DEBUG_ATOMIC_SLEEP was
enabled due to bug hunting in own code (and found yet another at an
unexpected place). 
I have chosen #ifdef CONFIG_PREEMPT to match with assembly code, but
your solution seems more reasonable.

Regards,
Patrik

-- 
Patrik KLUBA
Software Developer at

DENSION Audio Systems Ltd.
H-1116 Budapest, Sztregova u. 1
Phone: +36 1 463 0470
Fax:   +36 1 463 0479
Web:   www.dension.com
