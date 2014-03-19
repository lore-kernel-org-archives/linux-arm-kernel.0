From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 19 Mar 2014 13:29:00 +0100
Subject: [PATCH v2 5/7] sched: add a new SD_SHARE_POWERDOMAIN for
 sched_domain
In-Reply-To: <20140319120122.GK27632@laptop.programming.kicks-ass.net>
References: <1395165409-18055-1-git-send-email-vincent.guittot@linaro.org>
 <1395165409-18055-6-git-send-email-vincent.guittot@linaro.org>
 <20140319120122.GK27632@laptop.programming.kicks-ass.net>
Message-ID: <CAKfTPtBBbKGPTuPu_1-rxAv6ADSFzziWk5hgmrz-wB4dupm6eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 March 2014 13:01, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Mar 18, 2014 at 06:56:47PM +0100, Vincent Guittot wrote:
>> A new flag SD_SHARE_POWERDOMAIN is created to reflect whether groups of CPUs
>> in a sched_domain level can or not reach different power state. As an example,
>> the flag should be cleared at CPU level if groups of cores can be power gated
>> independently. This information can be used to add load balancing level between
>> group of CPUs than can power gate independantly. The default behavior of the
>> scheduler is to spread tasks across CPUs and groups of CPUs
>
>> so the flag is set into all sched_domains.
>
> I suppose that is the part Preeti stumbled over; as did I. Its not set
> at all.

yes, it's confusing. i'm going to update the commit message

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
