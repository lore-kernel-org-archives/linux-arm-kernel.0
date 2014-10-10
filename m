From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 10 Oct 2014 16:38:06 +0200
Subject: [PATCH v7 5/7] sched: get CPU's usage statistic
In-Reply-To: <20141009151211.GV10832@worktop.programming.kicks-ass.net>
References: <1412684017-16595-1-git-send-email-vincent.guittot@linaro.org>
 <1412684017-16595-6-git-send-email-vincent.guittot@linaro.org>
 <20141009113614.GP4750@worktop.programming.kicks-ass.net>
 <CAKfTPtDtfhQDWNjU5i-YpX4-Ak3nT3uaOCvhqgNP-u=-La7_gw@mail.gmail.com>
 <20141009151211.GV10832@worktop.programming.kicks-ass.net>
Message-ID: <CAKfTPtBVbs=sniL4UJ-Ax4zpVwf1ut8RVpYTVRnmYN4VOhhzvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 October 2014 17:12, Peter Zijlstra <peterz@infradead.org> wrote:

>> >> +static int get_cpu_usage(int cpu)
>> >> +{
>> >> +     unsigned long usage = cpu_rq(cpu)->cfs.utilization_load_avg;
>> >> +     unsigned long capacity = capacity_orig_of(cpu);
>> >> +
>> >> +     if (usage >= SCHED_LOAD_SCALE)
>> >> +             return capacity + 1;
>> >
>> > Like Morten I'm confused by that +1 thing.
>>
>> ok. the goal was to point out the erroneous case where usage is out of
>> the range but if it generates confusion, it can remove it
>
> Well, the fact that you clip makes that point, returning a value outside
> of the specified range doesn't.

i meant removing the +1
