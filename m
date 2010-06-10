From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 10 Jun 2010 15:18:14 -0400 (EDT)
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <20100610063234.GA22533@pengutronix.de>
References: <4C083BCF.2060500@bluewatersys.com>
	<alpine.LFD.2.00.1006081655350.30664@xanadu.home>
	<4C0ED074.7050700@bluewatersys.com>
	<201006090807.20810.post@hendrik-sattler.de>
	<1276090378.2006.11.camel@m0nster>
	<20100610063234.GA22533@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1006101513080.30664@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jun 2010, Uwe Kleine-K?nig wrote:

> I removed all lines from all defconfigs that don't affect the resulting
> .config basing on .35-rc1.  The diffstat is below.  As far as I checked
> there are no added lines and the 'pluses' are only context noise.  So
> the defconfigs are down to 124.4 (from 1214.4) lines on average.
> You can see the result at
> 
> 	http://git.pengutronix.de/?p=ukl/linux-2.6.git;a=commitdiff;h=arm/defconfig/reduced-v2.6.35-rc1
> 
> I'm currently reducing the defconfigs in .34 to be able to compare the
> diffstats between (.34 -> .35-rc1) and between (.34-reduced ->
> .35-reduced).  I would expect the diff is more or less the same as with
> the Kconfig idea.
> 
> Compared to the Kconfig idea I see a few advantages:
>  - Assuming that kautobuild would only use a base config + per arch
>    selections we would loose compile coverage of e.g. CONFIG_AEABI.

That is not acceptable of course.

Same thing for HIGHMEM, PREEMPT, SMP, etc.

>  - I have a script that reduces a config, so there is a bit less manual
>    work.
>  - No need to change kautobuild
> 
[...]
> 
>  177 files changed, 652 insertions(+), 194157 deletions(-)

That's really nice.


Nicolas
