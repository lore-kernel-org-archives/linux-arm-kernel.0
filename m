From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 18 Feb 2016 12:08:05 +0000
Subject: KASAN issues with idle / hotplug area
In-Reply-To: <56C5AF16.7020904@virtuozzo.com>
References: <56C1E072.2090909@virtuozzo.com>
 <20160215185957.GB19413@e104818-lin.cambridge.arm.com>
 <56C31D1D.50708@virtuozzo.com> <20160217143950.GC32647@leverpostej>
 <20160217170110.GE32647@leverpostej>
 <20160217175656.GJ32647@leverpostej>
 <20160217191643.GK32647@leverpostej>
 <56C57F40.3050500@virtuozzo.com>
 <20160218111516.GM32647@leverpostej>
 <56C5AF16.7020904@virtuozzo.com>
Message-ID: <20160218120805.GP32647@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 02:46:30PM +0300, Andrey Ryabinin wrote:
> 
> On 02/18/2016 02:15 PM, Mark Rutland wrote:
> > On Thu, Feb 18, 2016 at 11:22:24AM +0300, Andrey Ryabinin wrote:
> >> I see two options here:
> >>  * completely disable instrumentation for drivers/firmware/psci.c
> > 
> > This is somewhat overkill, and we'd also have to disable instrumentation
> > for arch/arm64/kernel/psci.c (for psci_suspend_finisher).
> > 
> > I would like to have instrumentation for everything we can safely
> > instrument.
> > 
> > This is probably the least worst option, though.
> > 
> >>  * get back to assembly implementation
> > 
> > We'd also have to convert psci_suspend_finisher and psci_cpu_suspend,
> > the latter being generic code. That goes against the consolidation we
> > were aiming for.
> > 
> 
> Yup, I missed these two.
> In that case the only way is to manually unpoison stack.

I'm prototyping this now.

Mark.
