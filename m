From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 30 Apr 2010 15:11:20 -0700
Subject: [PATCH V2] [ARM] Add ARCH_PROVIDES_UDELAY config option
In-Reply-To: <u2pd73d4eaf1004301237k3ceb859dobe74fe53abec774d@mail.gmail.com>
	(Colin Cross's message of "Fri\, 30 Apr 2010 12\:37\:40 -0700")
References: <1272654736-28837-1-git-send-email-ccross@android.com>
	<u2pd73d4eaf1004301237k3ceb859dobe74fe53abec774d@mail.gmail.com>
Message-ID: <87d3xgd20n.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin Cross <ccross@android.com> writes:

> An alternative to this patch would be to add a config option to use
> sched_clock() to provide the counter instead of the cycle loop.  The
> same loops_per_jiffy calibration could be done to  determine the
> sched_clock frequency.  Any machine with an available constant tick
> rate counter, which is likely to be used for sched_clock() already,
> can enable CONFIG_UDELAY_USES_SCHED_CLOCK.

Or even better, why not have an option to use the clocksource which is
most likely using the constant tick timer as well.

Kevin

> On Fri, Apr 30, 2010 at 12:12 PM, Colin Cross <ccross@android.com> wrote:
>> On SMP kernels, the loops_per_jiffy value is not scaled due to the
>> possibility of one CPU affecting the speed of another CPU while the
>> second CPU is in a udelay loop. ?Since loops_per_jiffy is calculated
>> once on boot for SMP kernels, udelays are too long if the CPU
>> frequency is scaled down from the boot frequency, or too short if the
>> frequency is scaled up. ?Some SOCs have a timer with a constant tick
>> rate that can be used to time udelays, similar to the TSC on x86.
>> Provide a config flag to allow these SOCs to override the default
>> ARM udelay implementation.
>>
>> Signed-off-by: Colin Cross <ccross@android.com>
