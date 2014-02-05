From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 5 Feb 2014 21:39:33 +0100 (CET)
Subject: [PATCH 2/2] clocksource: Make clocksource register functions void
In-Reply-To: <52E0D575.5050702@linaro.org>
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
 <52E0D575.5050702@linaro.org>
Message-ID: <alpine.DEB.2.02.1402052138170.24986@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Jan 2014, Daniel Lezcano wrote:
> On 01/23/2014 08:12 AM, Yijing Wang wrote:
> > Currently, clocksource_register() and __clocksource_register_scale()
> > functions always return 0, it's pointless, make functions void.
> > And remove the dead code that check the clocksource_register_hz()
> > return value.
> > 
> > Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> 
> Well, do we really want to change all these files to not take care of a return
> value ? What about is we have to check it again later ?
> 
> I would recommend to investigate __clocksource_register_scale and the
> underneath functions if there is not an error to be returned in the call stack
> somewhere which is ignored today.
> 
> The same applies for clocksource_register.

There is really no point in making it fail. It's so low level that
anything more than a proper printk/BUG/WARN is overkill.

Thanks,

	tglx
