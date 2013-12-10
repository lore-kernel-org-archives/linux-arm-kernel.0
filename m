From: ben@datarespons.no (=?utf-8?B?QmrDuHJuIEVyaWsgTmlsc2Vu?=)
Date: Tue, 10 Dec 2013 13:21:20 +0100
Subject: imx6 suspend/resume issue
Message-ID: <mailman.16.1386678432.1056.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have a nitrogen6x board (imx6q) from boundary devices and I've been
playing with power management on the 3.12 kernel.

There are issues related to suspend/resume. It looks like I can
successfully enter mem mode, however when I trigger one of the wakeup
sources I'm not able to resume successfully.

#echo mem > /sys/power/state

PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
Freezing user space processes ... (elapsed 0.001 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
PM: Entering mem sleep
PM: suspend of devices complete after 53.008 msecs
PM: suspend devices took 0.060 seconds
PM: late suspend of devices complete after 1.924 msecs
PM: noirq suspend of devices complete after 2.604 msecs
Disabling non-boot CPUs ...
CPU1: shutdown
CPU2: shutdown
CPU3: shutdown

<trigger wake-up source>

Enabling non-boot CPUs ...
CPU1: Booted secondary processor
CPU1 is up
CPU2: Booted secondary processor
CPU2 is up
CPU3: Booted secondary processor
CPU3 is up

And then the system hangs there. I have looked through recent patchwork
and I cannot find any obvious commits missing from my branch.

I'm thinking this must be a known issue and perhaps you can point me in
the right direction for what I should look for.

Best regards,
Bj?rn Erik Nilsen
