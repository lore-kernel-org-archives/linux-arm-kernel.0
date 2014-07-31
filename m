From: grant.b.edwards@gmail.com (Grant Edwards)
Date: Thu, 31 Jul 2014 13:59:36 +0000 (UTC)
Subject: Building kernel for more than one SoC
Message-ID: <lrdi48$ls1$1@ger.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm told that it should be possible to build a kernel that will run on
two different SoC chips.  They're closely related (same ARM9 core,
many identical internal peripherals -- AT91SAM9G20 and 'G25), and
would likely have identical external hardware.

In order to handle the internal periphals that differ, it was
recommended that I use loadable modules to keep the kernel size small.
However, my root filesystem is in RAM, so I don't see how loadable
modules helps unless I remove all of the .ko files from the root
filesystem after the kernel has booted.

It seems it would be simpler to just link in all required drivers for
both chips and discard the ones that aren't needed after kernel
initialization. But, I'm not sure if there's a mechanism for doing
that.  I know there's a way to declare a function or data that will be
discarded after kernel init, but is ther a way to that conditionally
depending on probed hardware or the device-tree used at boot-time?

-- 
Grant Edwards               grant.b.edwards        Yow! Let me do my TRIBUTE
                                  at               to FISHNET STOCKINGS ...
                              gmail.com            
