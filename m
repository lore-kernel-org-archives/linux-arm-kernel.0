From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 28 May 2014 12:58:55 +0200
Subject: [PATCH v2 09/11] sched: test the cpu's capacity in wake affine
In-Reply-To: <1400860385-14555-10-git-send-email-vincent.guittot@linaro.org>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-10-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140528105855.GR30445@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 05:53:03PM +0200, Vincent Guittot wrote:
> Currently the task always wakes affine on this_cpu if the latter is idle.
> Before waking up the task on this_cpu, we check that this_cpu capacity is not
> significantly reduced because of RT tasks or irq activity.
> 
> Use case where the number of irq and the time spent under irq is important
> will take benefit of this because the task that is woken up by irq or softirq
> will not use the same CPU than irq (and softirq) but a idle one which share
> its LLC.

OK, so I'm having a terrible time parsing the above.

So looking at the patch you make balance false even when this_load==0
when the effective power/capacity (nico's patches haven't fully sunk in
yet) of this cpu is less than that of the previous cpu.

Is that right?

Now I'm only struggling to understand the rationale for this, its got
LLC in there somewhere, but I'm failing to comprehend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/39dff26e/attachment.sig>
