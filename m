From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Dec 2013 20:56:54 +0800
Subject: imx6 suspend/resume issue
In-Reply-To: <52a7073b.c72b980a.2ec8.6fffSMTPIN_ADDED_MISSING@mx.google.com>
References: <52a7073b.c72b980a.2ec8.6fffSMTPIN_ADDED_MISSING@mx.google.com>
Message-ID: <20131210125652.GB26728@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 01:21:20PM +0100, Bj?rn Erik Nilsen wrote:
> Hi,
> 
> I have a nitrogen6x board (imx6q) from boundary devices and I've been
> playing with power management on the 3.12 kernel.
> 
> There are issues related to suspend/resume. It looks like I can
> successfully enter mem mode, however when I trigger one of the wakeup
> sources I'm not able to resume successfully.

It might be a nitrogen6x specific problem, as 3.12 kernel works fine on
my board (imx6q-sabresd).

root at arm:~# uname -a
Linux arm 3.12.0 #3 SMP Tue Dec 10 20:45:32 CST 2013 armv7l GNU/Linux
root at arm:~# echo mem > /sys/power/state
PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
Freezing user space processes ... (elapsed 0.001 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
PM: Entering mem sleep
PM: suspend of devices complete after 40.785 msecs
PM: suspend devices took 0.040 seconds
PM: late suspend of devices complete after 0.351 msecs
PM: noirq suspend of devices complete after 0.521 msecs
Disabling non-boot CPUs ...
CPU1: shutdown
CPU2: shutdown
CPU3: shutdown
Enabling non-boot CPUs ...
CPU1: Booted secondary processor
CPU1 is up
CPU2: Booted secondary processor
CPU2 is up
CPU3: Booted secondary processor
CPU3 is up
PM: noirq resume of devices complete after 0.271 msecs
PM: early resume of devices complete after 0.336 msecs
ata1: SATA link down (SStatus 0 SControl 300)
PM: resume of devices complete after 355.835 msecs
PM: resume devices took 0.360 seconds
PM: Finishing wakeup.
Restarting tasks ... done.
root at arm:~#

Shawn

> 
> #echo mem > /sys/power/state
> 
> PM: Syncing filesystems ... done.
> PM: Preparing system for mem sleep
> Freezing user space processes ... (elapsed 0.001 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> PM: Entering mem sleep
> PM: suspend of devices complete after 53.008 msecs
> PM: suspend devices took 0.060 seconds
> PM: late suspend of devices complete after 1.924 msecs
> PM: noirq suspend of devices complete after 2.604 msecs
> Disabling non-boot CPUs ...
> CPU1: shutdown
> CPU2: shutdown
> CPU3: shutdown
> 
> <trigger wake-up source>
> 
> Enabling non-boot CPUs ...
> CPU1: Booted secondary processor
> CPU1 is up
> CPU2: Booted secondary processor
> CPU2 is up
> CPU3: Booted secondary processor
> CPU3 is up
> 
> And then the system hangs there. I have looked through recent patchwork
> and I cannot find any obvious commits missing from my branch.
> 
> I'm thinking this must be a known issue and perhaps you can point me in
> the right direction for what I should look for.
