From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 May 2018 14:17:17 -0700
Subject: [PATCH v2] OMAP: CLK: CLKSRC: Add suspend resume hooks
In-Reply-To: <ea82b336-7e99-bc41-4b51-54fe208c5e55@ti.com>
References: <1527013340-8036-1-git-send-email-j-keerthy@ti.com>
 <20180523184116.GS98604@atomide.com>
 <ea82b336-7e99-bc41-4b51-54fe208c5e55@ti.com>
Message-ID: <20180523211717.GW98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* J, KEERTHY <j-keerthy@ti.com> [180523 20:40]:
> 
> 
> On 5/24/2018 12:11 AM, Tony Lindgren wrote:
> > * Keerthy <j-keerthy@ti.com> [180522 11:24]:
> > > Add the save and restore for clksrc as part of suspend and resume
> > > so that it saves the counter value and restores. This is needed in
> > > modes like rtc+ddr in self-refresh not doing this stalls the time.
> > Can't we now do this all in drivers/clocksource/timer-ti-*.c?
> 
> arch/arm/boot/dts/am4372.dtsi has compatible ti,omap-counter32k
> which is arch/arm/mach-omap2/timer.c compatible

Oh OK.

> IMHO clocksource suspend resume best fits under mach-omap2/timer.c
> just like clockevent has suspend/resume.

Yup you're right. Applying into omap-for-v4.18/soc thanks.
No guarantees at this point it will get merged though.

Regards,

Tony
