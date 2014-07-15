From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 15 Jul 2014 11:21:24 +0200
Subject: [PATCH v3 08/12] sched: move cfs task on a CPU with higher
 capacity
In-Reply-To: <20140714135106.GZ19379@twins.programming.kicks-ass.net>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-9-git-send-email-vincent.guittot@linaro.org>
 <20140710111833.GY3935@laptop>
 <CAKfTPtD=TiURcppZ+oVUmhMf6Ofxbp4BPA0SCFViu0SDb05oRw@mail.gmail.com>
 <20140711145138.GC3935@laptop>
 <CAKfTPtCdd6uR_qBuW2W4asMgEV=OfsNvrOCVQCci+w3C8RAoCQ@mail.gmail.com>
 <20140714135106.GZ19379@twins.programming.kicks-ass.net>
Message-ID: <CAKfTPtCoBpt5aOe9z2LjvOZBsiNnnC5wCFRyyOS_RPoqshJCxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 July 2014 15:51, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Jul 11, 2014 at 05:17:44PM +0200, Vincent Guittot wrote:
>> > In any case, its feels rather arbitrary to me. What about machines where
>> > there's no cache sharing at all (the traditional SMP systems). This
>> > thing you're trying to do still seems to make sense there.
>>
>> ok, I thought that traditional SMP systems have this flag set at core
>> level.
>
> Yeah, with 1 core, so its effectively disabled.
>
>> I mean ARM platforms have the flag for CPUs in the same cluster
>> (which include current ARM SMP system) and the corei7 of my laptop has
>> the flag at the cores level.
>
> So I can see 'small' parts reducing shared caches in order to improve
> idle performance.
>
> The point being that LLC seems a somewhat arbitrary measure for this.
>
> Can we try and see what happens if you remove the limit. Its always best
> to try the simpler things first and only make it more complex if we have
> to.

ok. i will remove the condition in the next version
