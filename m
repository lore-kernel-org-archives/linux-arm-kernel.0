From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 30 Sep 2009 17:22:53 +0200
Subject: [RFC] AT91 cpufreq support
In-Reply-To: <20090826193324.GB7084@pc-ras4041.res.insa>
References: <20090826193324.GB7084@pc-ras4041.res.insa>
Message-ID: <4AC377CD.5020809@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Albin Tonnerre :
> Hi there,
> 
> Here is an updated version of the patch that brings cpufreq support on AT91.
> This one is more generic that the previous one: instead of using fixed values,
> it gets the current prescaler value and builds the frequency table accordingly.
> 
> It fixes a couple mistakes from the previous iteration, making it work more
> reliably, at least there. I also added a cpufreq notifier to atmel_serial, so
> that we don't lose the console over a frequency change (I'll move it to a
> separate patch in a further update, and will add such support for the macb
> driver too).
> As there's no cpufreq notifier in the macb driver (yet), using cpufreq with a
> NFS root filesystem will fail (obviously, other uses of the network will
> probably fail too, but at least they don't make the system unusable)
> 
> On a Calao USB-A9263 board, switching from 180MHz to 11MHz reduces the current
> consumption by roughly 65mA
> 
> Testing/feedback would be very much welcome

I am testing your cpufreq patch on at91sam9263ek board.

Indeed it is working quite well. But, I it is true that we will have to
add notifiers for several drivers: my LCD screen gets messy while
reducing frequency ;-)

Anyway, as I see that there is a notifier for serial driver, I wonder if
we can keep serial console connexion during frequency switching ? I
assume that we will have to change the baud rate configuration of the
terminal emulator but do you have a clue to give us (I tried without
success) ?

On my test case: at91sam9263ek without LCD backlight I have those
values: 1,63W @ 199MHz and 1,28W @ 12MHz => 21% gain: good !

Bye-bye,
-- 
Nicolas Ferre
