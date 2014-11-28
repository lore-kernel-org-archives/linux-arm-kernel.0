From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 12:37:01 +0100
Subject: [GIT PULL] temporarily disable rk3288-smp
In-Reply-To: <13624879.qYkvC9sWa4@diego>
References: <13624879.qYkvC9sWa4@diego>
Message-ID: <201411281237.01480.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 22 November 2014, Heiko St?bner wrote:
> it looks like not all bootloaders like the recently introduced
> rk3288-smp-support. Uninitialized CNTVOFF registers of the
> architected timer produce rcu stalls on some boards.
> 
> Both Olof and Kevin were affected by this. On Kevin's board
> we could simply upgrade u-boot to a version behaving correctly
> while Olof's board uses coreboot where no fix for this exists
> currently. Also as far as I know Olof's board is the only one
> in circulation using coreboot, but it would still be nice to keep
> the boot tests working for the time being.
> 
> There exist an alternative approach for solving issues like this
> consisting of
> - clocksource: arch_timer: Fix code to use physical timers when requested [0]
> - clocksource: arch_timer: Allow the device tree to specify uninitialized timer registers [1]
> 
> 
> So to keep Olof's boottests working, disable the rk3288-smp until this
> gets sorted. Interested parties with a working bootloader can of course
> always simply re-insert the enable-method to have working smp.
> 

Pulled into next/dt, thanks!

	Arnd
