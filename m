From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 07 Dec 2015 16:59:10 +0000
Subject: [PATCH] arm64: dts: Add idle-states for Juno
In-Reply-To: <20151124175343.GA13156@red-moon> (Lorenzo Pieralisi's message of
 "Tue, 24 Nov 2015 17:53:43 +0000")
References: <1430402268.2868.20.camel@linaro.org>
 <9hheggnca1y.fsf@e105922-lin.cambridge.arm.com>
 <1445868751.2807.21.camel@linaro.org>
 <20151026151709.GA16145@red-moon>
 <9hh7fl8lie1.fsf@e105922-lin.cambridge.arm.com>
 <20151124175343.GA13156@red-moon>
Message-ID: <878u56tctd.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> On Mon, Nov 23, 2015 at 05:45:10PM +0000, Punit Agrawal wrote:
>> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
>> 
>> > On Mon, Oct 26, 2015 at 02:12:31PM +0000, Jon Medhurst (Tixy) wrote:
>> >> On Thu, 2015-10-22 at 14:22 +0100, Punit Agrawal wrote:
>> >> > "Jon Medhurst (Tixy)" <tixy@linaro.org> writes:
>> >> > 
>> >> > > From: Jon Medhurst <tixy@linaro.org>
>> >> > >
>> >> > > Signed-off-by: Jon Medhurst <tixy@linaro.org>
>> >> > 
>> >> > Apologies for resurrecting an old thread.
>> >> > 
>> >> > Following the discussion on this thread, even though certain concerns
>> >> > were raised, there wasn't any objection to $SUBJECT being merged.
>> >> > 
>> >> > I don't see this patch in any tree; perhaps it's slipped through the
>> >> > cracks.
>> >> 
>> >> It did slip through the cracks. Lorenzo's last comment was "I am fine
>> >> with enabling the idle states, I need to review and test the idle states
>> >> DT data in the patch first though." and I didn't chase things up.
>> >> 
>> >> The patch will need refreshing to add idle for Juno r1. Which will then
>> >> probably resurrect the discussion about where the numbers come from for
>> >> residency times, and are the same ones for r0 valid on r1 (and r2?).
>> >> 
>> >> In an effort to forestall that I would say: does anyone actually care if
>> >> the values are optimal? Juno is a reference platform and powered off
>> >> mains, so tuning for the optimum power consumption is pretty pointless.
>> >> But because it _is_ used as a reference by people it should at least
>> >> have these features enabled, to serve as an example, and for test
>> >> coverage.
>> >
>> > I agree with you here, let me check the entry/exit latencies again
>> > to make sure they are reasonably set-up, it is 4.5 material anyway.
>> 
>> Hi Lorenzo,
>> 
>> Have you had a chance to sanity check the values we've got here? I
>> didn't want to miss this merge window if possible.
>
> Yes and they need updating. This data is really really FW dependent,
> that's the reason why I still think that these values should be provided
> by FW and not shoved into the kernel. Anyway, here we go (I assume the
> worst case and that's the only safe option I can see):
>
> - the entry-latency should be set to 300us for _both_ idle states
> - the exit-latency should be set to 1.2ms for _both_ idle states
>
> The min-residency values looks reasonable, a tad optimistic (but again
> that's workload and FW dependent so either we settle for the worst
> possible case or we do not merge this at all).
>
> With the changes above:
>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Tixy,

Could you please refresh this patch with the changes suggested by
Lorenzo? We might still be able to get it in for 4.4.

Thanks,
Punit

ps: Apologies if I've missed a new posting with these changes.

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
