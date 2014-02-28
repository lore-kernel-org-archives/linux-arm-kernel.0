From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Feb 2014 15:34:02 -0800
Subject: [PATCH V2 4/4] ARM: OMAP2+: AM43x: Use gptimer as clocksource
In-Reply-To: <530B4391.2050205@ti.com>
References: <1391768486-2134-1-git-send-email-lokeshvutla@ti.com>
 <1391768486-2134-5-git-send-email-lokeshvutla@ti.com>
 <20140213231919.GO28216@atomide.com> <52FDD7D5.30508@ti.com>
 <530B4391.2050205@ti.com>
Message-ID: <20140228233402.GY13624@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lokesh Vutla <lokeshvutla@ti.com> [140224 05:08]:
> Hi Tony,
> On Friday 14 February 2014 02:16 PM, Rajendra Nayak wrote:
> > On Friday 14 February 2014 04:49 AM, Tony Lindgren wrote:
> >> * Lokesh Vutla <lokeshvutla@ti.com> [140207 02:24]:
> >>> From: Rajendra Nayak <rnayak@ti.com>
> >>>
> >>> The SyncTimer in AM43x is clocked using the following two sources:
> >>> 1) An inaccuarte 32k clock (CLK_32KHZ) derived from PER DPLL, causing system
> >>>    time to go slowly (~10% deviation).
> >>> 2) external 32KHz RTC clock, which may not always be available on board like
> >>>    in the case of ePOS EVM
> >>>
> >>> Use gptimer as clocksource instead, as is done in the case of AM335x
> >>> (which does not have a SyncTimer). With this, system time keeping works
> >>> accurately.
> >>
> >> Hmm doesn't this also mean that PM for any deeper idle states won't
> >> work properly?
> > 
> > Thats true. This would mean we cannot put the peripheral/core domain down
> > in idle. Suspend however can still work if suspend/resume callbacks are added
> > to the clockevent and clocksource code to shut the non-wakeup domain timer.
> This is a platform level limitation that only MPU domain can be put down in idle, just like AM335x.

OK applying all four into omap-for-v3.15/soc thanks.

Tony
