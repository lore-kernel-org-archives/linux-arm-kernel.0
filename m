From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 4 May 2018 20:24:22 +0200
Subject: [PATCH 1/6] locking/atomic, asm-generic: instrument ordering
 variants
In-Reply-To: <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
Message-ID: <20180504182422.GT12217@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 07:09:09PM +0100, Mark Rutland wrote:
> On Fri, May 04, 2018 at 08:01:05PM +0200, Peter Zijlstra wrote:
> > On Fri, May 04, 2018 at 06:39:32PM +0100, Mark Rutland wrote:

> > >  include/asm-generic/atomic-instrumented.h | 1195 ++++++++++++++++++++++++-----
> > >  1 file changed, 1008 insertions(+), 187 deletions(-)
> > 
> > Is there really no way to either generate or further macro compress this?
> 
> I can definitely macro compress this somewhat, but the bulk of the
> repetition will be the ifdeffery, which can't be macro'd away IIUC.

Right, much like what we already have in linux/atomic.h I suspect,
having to duplicating that isn't brilliant either.

> Generating this with a script is possible -- do we do anything like that
> elsewhere?

There's include/generated/ in your build directory. But nothing on this
scale I think.
