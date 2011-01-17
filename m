From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 17 Jan 2011 21:43:03 +0100
Subject: [PATCH] sched: provide scheduler_ipi() callback in response to
	smp_send_reschedule()
In-Reply-To: <1295296310.2148.29.camel@pasglop>
References: <1295262433.30950.53.camel@laptop>
	<1295296310.2148.29.camel@pasglop>
Message-ID: <1295296983.30950.369.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-01-18 at 07:31 +1100, Benjamin Herrenschmidt wrote:
> 
> Beware of false positive, I've used "fake" reschedule IPIs in the past
> for other things (like kicking a CPU out of sleep state for unrelated
> reasons). Nothing that I know that is upstream today but some of that
> might come back. I'd like to avoid having to add an atomic to know if
> it's a real reschedule, will the scheduler be smart enough to not bother
> with false positives ? 

Yes it can deal with that, some will be for reschedules, some will be
for ttwu tail ends and x86 too uses this ipi for a few random other
things like kicking kvm out of guest context..
