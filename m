From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 29 Sep 2014 08:11:25 -0700
Subject: [PATCH] sched/nohz: add debugfs control over
 sched_tick_max_deferment
In-Reply-To: <20140927165938.GB21729@lerouge> (Frederic Weisbecker's message
 of "Sat, 27 Sep 2014 18:59:39 +0200")
References: <1411760732-14102-1-git-send-email-khilman@kernel.org>
 <20140927165938.GB21729@lerouge>
Message-ID: <7hh9zq31ia.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Frederic Weisbecker <fweisbec@gmail.com> writes:

> On Fri, Sep 26, 2014 at 12:45:32PM -0700, Kevin Hilman wrote:
>> From: Kevin Hilman <khilman@linaro.org>
>> 
>> Allow debugfs override of sched_tick_max_deferment in order to ease
>> finding/fixing the remaining issues with full nohz.
>> 
>> The value to be written is in jiffies, and -1 means the max deferment
>> is disabled (scheduler_tick_max_deferment() returns KTIME_MAX.)
>> 
>> Cc: Frederic Weisbecker <fweisbec@gmail.com>
>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>
> So, I'm worried that it becomes a hack that everybody uses to shutdown
> the tick completely then nobody will come and fix the issue that prevents
> from doing it properly.

OK.

> I seriously doubt this will be used for development purpose to help
> fixing the real problem. 

Well, that's what I was using it for, until I was distracted by other
tasks.

> Quite the opposite. If developers want to do
> testing, they can as well comment out the call to scheduler_max_tick_deferment().

OK, fair enough.

Thanks,

Kevin
