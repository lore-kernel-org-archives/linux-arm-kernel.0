From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 17 Mar 2011 15:42:02 +0530
Subject: [RFC PATCHv2 14/20] ARM: omap4: dynamically register local
	timersetup function
In-Reply-To: <1300269821.21713.37.camel@e102391-lin.cambridge.arm.com>
References: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
	<1300201983-26124-15-git-send-email-marc.zyngier@arm.com>
	<f77caa44aa0205d3687b0dcae796c42b@mail.gmail.com>
	<1300269821.21713.37.camel@e102391-lin.cambridge.arm.com>
Message-ID: <5f23aa9c1bf56777271c8619ddeb212c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Marc Zyngier [mailto:Marc.Zyngier at arm.com]
> Sent: Wednesday, March 16, 2011 3:34 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel at lists.infradead.org; Tony Lindgren
> Subject: RE: [RFC PATCHv2 14/20] ARM: omap4: dynamically register
> local timersetup function
>
[....]

> > This way the kernel built with CONFIG_LOCAL_TIMERS can still work
> > on SoCs where twd isn't supported.
> >
> > Looks like your patch breaks that unless and until I am missing
> > something.
>
> I think the bit you're missing is that when no local timer is
> registered, the code in percpu_timer.c::percpu_timer_setup() ensures
> that the broadcast timers are used as a default.
>
> In the OMAP4 case, twd is registered unless we detect a
> OMAP4430_REV_ES1_0. In that case, we let the magic happen and fall
> back
> to the broadcast timers. Tested on a PandaBoard with twd
> artificially disabled.
>
Cool.
Thanks for the update.
