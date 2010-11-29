From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 29 Nov 2010 19:25:30 +0900
Subject: [Question] Local Timer based on SPI
In-Reply-To: <20101126091004.GD9310@n2100.arm.linux.org.uk>
References: <000001cb8d0d$dbacd760$93068620$%kim@samsung.com>
	<20101126091004.GD9310@n2100.arm.linux.org.uk>
Message-ID: <000b01cb8faf$c1841a20$448c4e60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> 
> On Fri, Nov 26, 2010 at 11:01:31AM +0900, Kukjin Kim wrote:
> > Current ARM Local Timer code is based on PPI using.
> > If want to use SPI on local timer, what approach is right or better?
> 
> SPI interrupts only go to one core at a time.  You can't have local
> timer support off a targetted interrupt.

Hi Russell,

Thank you for your reply :-)

Yeah, it seems CONFIG_LOCAL_TIMER is just for PPI.

The purpose of my question is for the plan to use different SPIs to support
each CPU event timer. According to the help message of LOCAL_TIMER in
Kconfig, it seems better each CPU has a different event timer source clock
instead of using IPI broadcast method. Current ARM implementation registers
dummy_timers when CONFIG_LOCAL_TIMERS is not set so, I think need to set
CONFIG_LOCAL_TIMERS.

To support different SPIs for each CPU event timer, should I neglect the
dummy_timer?
Or is it not worth to implement?...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
