From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Jan 2013 20:47:28 +0530
Subject: [RFC v2 13/18] ARM: OMAP2+: AM33XX: timer: Interchance clkevt
 and clksrc timers
In-Reply-To: <1356959231-17335-14-git-send-email-vaibhav.bedia@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-14-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <50EC3888.1070504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> AM33XX has two timers (DTIMER0/1) in the WKUP domain.
> On GP devices the source of DMTIMER0 is fixed to an
> inaccurate internal 32k RC oscillator and this makes
> the DMTIMER0 practically either as a clocksource or
> as clockevent.
>
> Currently the timer instance in WKUP domain is used
> as the clockevent and the timer in non-WKUP domain
> as the clocksource. DMTIMER1 in WKUP domain can keep
> running in suspend from a 32K clock fed from external
> OSC and can serve as the persistent clock for the kernel.
> To enable this, interchange the timers used as clocksource
> and clockevent for AM33XX.
>
> For now a new DT property has been added to allow the timer code
> to select the timer with the right property.
>
> It has been pointed out by Santosh Shilimkar and Kevin Hilman
> that such a change will result in soc-idle never being achieved
> on AM33XX. There are other reasons why soc-idle does not look
> feasible on AM33XX so for now we go ahead with the interchange
> of the the timers. If at a later point of time we do come up
> with an approach which makes soc-idle possible on AM33XX, this
> can be revisited.
>
Can you please explain other reasons as well for clarity ?

Regards
Santosh
