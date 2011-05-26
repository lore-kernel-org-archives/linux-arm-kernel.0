From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 26 May 2011 17:59:44 +0200
Subject: [BUG] "sched: Remove rq->lock from the first half of ttwu()"
	locks up on ARM
In-Reply-To: <20110526154508.GA13788@redhat.com>
References: <1306260792.27474.133.camel@e102391-lin.cambridge.arm.com>
	<1306272750.2497.79.camel@laptop> <1306343335.21578.65.camel@twins>
	<1306358128.21578.107.camel@twins>
	<BANLkTi=XbTXQsu3jUEvQyCfBy6-aRnqSpw@mail.gmail.com>
	<1306405979.1200.63.camel@twins>
	<1306407759.27474.207.camel@e102391-lin.cambridge.arm.com>
	<1306409575.1200.71.camel@twins> <1306412511.1200.90.camel@twins>
	<20110526154508.GA13788@redhat.com>
Message-ID: <1306425584.2497.81.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-26 at 17:45 +0200, Oleg Nesterov wrote:
> Stupid question. Can't we fix this problem if we do
> 
>         -       if (p == current)
>         +       if (cpu == raw_smp_processor_id())
> 
> ?
> 
> I forgot the rules... but iirc task_cpu(p) can't be changed under us?

Easy enough to test.. brain gave out again,. hold on ;-)
