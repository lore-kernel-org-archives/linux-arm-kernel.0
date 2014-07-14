From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 14 Jul 2014 17:28:21 +0000 (UTC)
Subject: OMAP baseline test results for v3.16-rc4
In-Reply-To: <20140707080238.GF28884@atomide.com>
References: <alpine.DEB.2.02.1407062339420.15016@utopia.booyaka.com>
 <20140707080238.GF28884@atomide.com>
Message-ID: <alpine.DEB.2.02.1407141719560.22162@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Jul 2014, Tony Lindgren wrote:

> With v3.16-rc4 the PM features for omap3 should be working
> finally for device tree based booting. At lest beaglexm and
> 3xxevm should work.
> 
> Maybe you are using legacy booting path to idle the UARTs still?
> 
> FYI, I'm doing this to find the UART entries:
> 
> uarts=$(find /sys/class/tty/ttyO*/device/power/ -type d)
> for uart in $uarts; do
>         echo 3000 > $uart/autosuspend_delay_ms
> done
> 
> uarts=$(find /sys/class/tty/ttyO*/power/ -type d)
> for uart in $uarts; do
>         echo enabled > $uart/wakeup
>         echo auto > $uart/control
> done
> 
> echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode

OK thanks, I'll take a close look at it.  It's not using the legacy paths, 
but based on a glance at the 37xxevm logs, it looks like the bus address 
of the UART isn't right.


- Paul
