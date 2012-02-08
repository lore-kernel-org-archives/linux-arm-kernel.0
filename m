From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Feb 2012 15:24:57 +0000
Subject: [PATCH] sched: generalize CONFIG_IRQ_TIME_ACCOUNTING for X86
 and ARM
In-Reply-To: <4F32918E.9000905@linaro.org>
References: <1328705314-20978-1-git-send-email-dmitry.antipov@linaro.org>
 <20120208131833.GK889@n2100.arm.linux.org.uk> <4F32918E.9000905@linaro.org>
Message-ID: <20120208152457.GN889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 07:15:26AM -0800, Dmitry Antipov wrote:
> On 02/08/2012 05:18 AM, Russell King - ARM Linux wrote:
>> Why are you placing this here?  sched_clock is available from the point
>> that it's registered, which should be before the first sched_clock()
>> call.
>
> This is just because I'm thinking about:
>
> if (read_sched_clock == jiffy_sched_clock_read)
>         setup_sched_clock(jiffy_sched_clock_read, 32, HZ);
> else if (!no_sched_irq_time)
> 	enable_sched_clock_irqtime();
>
> I suppose that "fine granularity task irq time accounting"
> makes no sense if sched_clock() granularity is poor.

Let me put it a different way - is there a reason not to do this in
setup_sched_clock() so that it becomes available as soon as sched_clock()
has been initialized by a platform?
