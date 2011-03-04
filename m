From: mboards@prograde.net (Michael Cashwell)
Date: Fri, 4 Mar 2011 13:42:17 -0500
Subject: PXA270 Random Hangs at Low Core Freq
In-Reply-To: <201103041816.08109.anarsoul@gmail.com>
References: <471CD45F-4531-4C87-B292-411CE519D0A5@prograde.net>
	<AANLkTi=Y-JYQ_eZ4EdNirPrm_xkiduSZP19BPWckP2iW@mail.gmail.com>
	<A6E7D305-39A1-42B3-8A2B-0D2CDBBE5EEE@prograde.net>
	<201103041816.08109.anarsoul@gmail.com>
Message-ID: <8C145DA2-AEF8-42AC-A4FB-C93003808D8C@prograde.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mar 4, 2011, at 11:16 AM, Vasily Khoruzhick wrote:

> Hi, Michael, recently I discovered that PXA270 (at least in Zipit Z2) works unstable (just hangs randomly) with fastbus bit set in CCLKCFG, check if bootloader sets it on your board, and if it does try to clear it.

Hi Vasily,

Thanks for the info. The curious thing is that arch/arm/mach-pxa/cpufreq-pxa2xx.c has a data table called pxa27x_freqs[] that seems to have FASTBUS set to true for all frequencies. So if CPUFREQ is enabled (which I do to save power) the kernel will enable FASTBUS even if the boot loader does not.

The boot loader would control that feature only if CPUFREQ were turned off (either in the config or dynamically). Is that the case you mean? If you are not using CPUFREQ in Linux what fixed frequency are you running?

What I've ultimately done is comment out all the lower frequencies. If it only switches between 416, 520 and 624 MHz it works fine. It only hangs for me if I also allow the lower frequencies, and interestingly, the lower I allow the sooner the hang happens. It's unfortunate since the lower frequencies would save more power but I simply cannot make them work reliably.

I've still not been able to identify why this happens (largely since JTAG becomes unresponsive) or find any published errata that I'm not accounting for.

-Mike
