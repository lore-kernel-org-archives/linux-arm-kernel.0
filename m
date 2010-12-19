From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Dec 2010 14:49:50 +0000
Subject: [PATCH 0/40] Complete set of clocksource/sched_clock patches
In-Reply-To: <19726.4420.289089.490319@pilspetsen.it.uu.se>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<19725.57447.256528.883703@pilspetsen.it.uu.se>
	<20101219105209.GN9937@n2100.arm.linux.org.uk>
	<19725.64412.395353.947407@pilspetsen.it.uu.se>
	<20101219125508.GG3047@n2100.arm.linux.org.uk>
	<19726.4420.289089.490319@pilspetsen.it.uu.se>
Message-ID: <20101219144950.GH3047@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 19, 2010 at 03:05:56PM +0100, Mikael Pettersson wrote:
> tmr = timer mode register
> tcr = timer counter register
> trr = timer reload register
> 
> When a timer is in periodic mode it reloads itself from its reload
> register when the counter register decrements to zero.

Ok.

>  >  Does trr need to be written in
>  > ->set_mode (if so that's another bug in this code)?
> 
> trr{0,1} need not and should not be changed after iop_time_init().

It sounds like trr0 needs to be written in ->set_mode's
CLOCK_EVT_MODE_PERIODIC path then, because with my patch, we never set
this register.  Or will trr0 be updated when we write tcr0 ?
