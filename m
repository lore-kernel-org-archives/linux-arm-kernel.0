From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu, 8 Nov 2018 15:09:35 +0100
Subject: [PATCH v7 0/7] clocksource: rework Atmel TCB timer driver
In-Reply-To: <20181108124327.iqdiif6atfrxdkef@linutronix.de>
References: <20180913113024.3571-1-alexandre.belloni@bootlin.com>
 <5f19043a-3be3-e25a-849f-6ca610ed6da2@linaro.org>
 <20180925201456.GD3112@piout.net>
 <20181108124327.iqdiif6atfrxdkef@linutronix.de>
Message-ID: <20181108140935.GI21694@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2018 13:43:27+0100, Sebastian Andrzej Siewior wrote:
> On 2018-09-25 22:14:56 [+0200], Alexandre Belloni wrote:
> > On 22/09/2018 13:29:48+0200, Daniel Lezcano wrote:
> > > You say for rt the PIT is not suitable because of the shared irq but in
> > > the driver, the interrupt is flagged as shared.
> > > 
> > 
> > Well, it is not simply sharing the interrupt that is an issue, it is the
> > mismatch between the PIT and the UART interrupt flags and that only
> > happens when using preempt-rt.
> 
> This should also happen on !RT with the threadedirq command line switch.
> The UART will be threaded and the PIT will not, and this is the problem.
> So we need to split those or disable the UART. The other important thing
> for RT is the higher resolution of the clocksource/clockevents device (I
> don't know if this is part of the series or not?).
> 

It is not part of that series as I prefer to keep the discussion of how
to configure that for later. This has been raised previously without any
conclusion and I'd really like to see this rework enter upstream soon.

> I'm currently replacing the v6 with this v7 in my RT tree. What is the
> status of this series upstream wise?
> 

I'll send v8 sometimes next week.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
