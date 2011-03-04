From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 4 Mar 2011 20:51:47 +0200
Subject: PXA270 Random Hangs at Low Core Freq
In-Reply-To: <8C145DA2-AEF8-42AC-A4FB-C93003808D8C@prograde.net>
References: <471CD45F-4531-4C87-B292-411CE519D0A5@prograde.net>
	<201103041816.08109.anarsoul@gmail.com>
	<8C145DA2-AEF8-42AC-A4FB-C93003808D8C@prograde.net>
Message-ID: <201103042051.47553.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 March 2011 20:42:17 Michael Cashwell wrote:
 
> Hi Vasily,
> 
> Thanks for the info. The curious thing is that
> arch/arm/mach-pxa/cpufreq-pxa2xx.c has a data table called pxa27x_freqs[]
> that seems to have FASTBUS set to true for all frequencies. So if CPUFREQ
> is enabled (which I do to save power) the kernel will enable FASTBUS even
> if the boot loader does not.

Yep, cpufreq was unstable on Zipit Z2, but after fixing pxa27x_freqs table to 
disable fastbus bit it works OK.
 
> The boot loader would control that feature only if CPUFREQ were turned off
> (either in the config or dynamically). Is that the case you mean? If you
> are not using CPUFREQ in Linux what fixed frequency are you running?
> 
> What I've ultimately done is comment out all the lower frequencies. If it
> only switches between 416, 520 and 624 MHz it works fine. It only hangs
> for me if I also allow the lower frequencies, and interestingly, the lower
> I allow the sooner the hang happens. It's unfortunate since the lower
> frequencies would save more power but I simply cannot make them work
> reliably.

Can you check if lower freqs work for you with fastbit not set?

> I've still not been able to identify why this happens (largely since JTAG
> becomes unresponsive) or find any published errata that I'm not accounting
> for.

Maybe this errata is not documented yet? :)

> -Mike

Regards
Vasily
