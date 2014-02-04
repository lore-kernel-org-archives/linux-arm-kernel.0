From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Tue, 4 Feb 2014 18:54:52 +0200
Subject: [PATCH v4 1/3] clocksource: timer-keystone: introduce clocksource
 driver for Keystone
In-Reply-To: <alpine.DEB.2.02.1402041715220.24986@ionos.tec.linutronix.de>
References: <1391513453-21140-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1391513453-21140-2-git-send-email-ivan.khoronzhuk@ti.com>
 <alpine.DEB.2.02.1402041715220.24986@ionos.tec.linutronix.de>
Message-ID: <52F11B5C.40407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was so in v1. But it was decided to use explicit memory barriers,
because we're always sure the memory barriers are there and that
they're properly documented. Also in this case I don't need to add
keystone readl/writel relaxed function variants and to use mixed calls of
writel/writel_relaxed functions.

See:
http://www.spinics.net/lists/arm-kernel/msg294941.html

On 02/04/2014 06:24 PM, Thomas Gleixner wrote:
> On Tue, 4 Feb 2014, Ivan Khoronzhuk wrote:
>> +	keystone_timer_writel(off, TCR);
>> +	/* here we have to be sure the timer has been disabled */
>> +	wmb();
> We have explicit writew_relaxed and writew. Why open coding the
> barriers?
>
> Thanks,
>
> 	tglx

-- 
Regards,
Ivan Khoronzhuk
