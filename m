From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 26 Nov 2015 02:19:48 +0000
Subject: [PATCH v2 2/2] ARM: Replace calls to __aeabi_{u}idiv with
 udiv/sdiv instructions
In-Reply-To: <20151126012859.GX8644@n2100.arm.linux.org.uk> (Russell King's
 message of "Thu, 26 Nov 2015 01:28:59 +0000")
References: <1448488264-23400-1-git-send-email-sboyd@codeaurora.org>
 <1448488264-23400-3-git-send-email-sboyd@codeaurora.org>
 <alpine.LFD.2.20.1511251733570.22569@knanqh.ubzr>
 <yw1x8u5lpqqz.fsf@unicorn.mansr.com>
 <alpine.LFD.2.20.1511251931050.22569@knanqh.ubzr>
 <yw1x4mg9posf.fsf@unicorn.mansr.com>
 <20151126012859.GX8644@n2100.arm.linux.org.uk>
Message-ID: <yw1xziy1o62j.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Thu, Nov 26, 2015 at 12:50:08AM +0000, M?ns Rullg?rd wrote:
>> If not calling the function saves an I-cache miss, the benefit can be
>> substantial.  No, I have no proof of this being a problem, but it's
>> something that could happen.
>
> That's a simplistic view of modern CPUs.
>
> As I've already said, modern CPUs which have branch prediction, but
> they also have speculative instruction fetching and speculative data
> prefetching - which the CPUs which have idiv support will have.
>
> With such features, the branch predictor is able to learn that the
> branch will be taken, and because of the speculative instruction
> fetching, it can bring the cache line in so that it has the
> instructions it needs with minimal or, if working correctly,
> without stalling the CPU pipeline.

It doesn't matter how many fancy features the CPU has.  Executing more
branches and using more cache lines puts additional pressure on those
resources, reducing overall performance.  Besides, the performance
counters readily show that the prediction is nothing near as perfect as
you seem to believe.

-- 
M?ns Rullg?rd
mans at mansr.com
