From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Sep 2011 10:05:48 -0700
Subject: [PATCH v15 06/12] OMAP: dmtimer: switch-over to platform
	device driver
In-Reply-To: <20110915165810.GA2284@atomide.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
	<1315516098-29761-7-git-send-email-tarun.kanti@ti.com>
	<20110914214533.GA30941@atomide.com>
	<CAC83ZvJgPYb3JbWT4SKXpQvq-vdKK4b6hd6E-ik5uyRCqgwWsg@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302575A050D@dbde02.ent.ti.com>
	<20110915165810.GA2284@atomide.com>
Message-ID: <20110915170548.GB2284@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110915 09:24]:
> * Mohammed, Afzal <afzal@ti.com> [110915 01:13]:
> > 
> > We need clocksource & clockevent to be able to work with
> > timers requiring addition of offsets. Without this AM335X,
> > TI816X and TI814X SoC's will not boot.
> 
> OK. Then how about let's do the following things:
> 
> 1. Modify the inline access functions to take the PEND and others
>    if needed registers as a parameter
> 
> 2. Modify mach-omap2/timer.c to initialize the PEND and others
>    in the SoC specific timer_init function

Also, let's do these changes first then rebase the dmtimer
series on those changes as it simplifies the dmtimer series
a bit.

Regards,

Tony
