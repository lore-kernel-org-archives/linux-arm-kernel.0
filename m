From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 24 Oct 2015 18:58:18 +0900 (KST)
Subject: Problem about CPU stalling in hrtimer_intterrupts()
In-Reply-To: <5628E7E9.409@huawei.com>
References: <56288585.40204@huawei.com>
 <alpine.DEB.2.11.1510220942010.4012@nanos> <5628AC58.2030509@huawei.com>
 <alpine.DEB.2.11.1510221133590.4012@nanos> <5628E7E9.409@huawei.com>
Message-ID: <alpine.DEB.2.11.1510241854410.4639@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Oct 2015, Yang Yingliang wrote:

> But I found out when the cpu is stalling, basenow.tv64(7676664221321) is
> bigger than ktime_get().tv64(7336008904750) in hrtimer_interrupt() and
> the timer->_softexpires is 7336288000000. This makes it can not finish
> the while loop until ktime_get().tv64 arrives basenow.tv64.
> 
> Is it correct that basenow bigger than ktime_get() ?

You only can compare basenow and ktime_get() for the clock monotonic
base. If you are actually observing this on clock monotonic base then
base->offset of clock monotonic is not 0, which should never happen.

Thanks,

	tglx
