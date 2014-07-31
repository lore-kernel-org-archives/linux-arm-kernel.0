From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 31 Jul 2014 23:07:37 +0200
Subject: Building kernel for more than one SoC
In-Reply-To: <lrdi48$ls1$1@ger.gmane.org>
References: <lrdi48$ls1$1@ger.gmane.org>
Message-ID: <20140731230737.66e94c3d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Grant Edwards,

(Adding Boris and Alexandre in Cc, since they do a lot of AT91 stuff
these days.)

On Thu, 31 Jul 2014 13:59:36 +0000 (UTC), Grant Edwards wrote:

> I'm told that it should be possible to build a kernel that will run on
> two different SoC chips.  They're closely related (same ARM9 core,
> many identical internal peripherals -- AT91SAM9G20 and 'G25), and
> would likely have identical external hardware.
> 
> In order to handle the internal periphals that differ, it was
> recommended that I use loadable modules to keep the kernel size small.
> However, my root filesystem is in RAM, so I don't see how loadable
> modules helps unless I remove all of the .ko files from the root
> filesystem after the kernel has booted.
> 
> It seems it would be simpler to just link in all required drivers for
> both chips and discard the ones that aren't needed after kernel
> initialization. But, I'm not sure if there's a mechanism for doing
> that.  I know there's a way to declare a function or data that will be
> discarded after kernel init, but is ther a way to that conditionally
> depending on probed hardware or the device-tree used at boot-time?

I don't think there's much point in worrying about this: the 9G20 and
9G25 will use identical device drivers for the vast majority of the
hardware blocks of the SoC, so the overhead of having the drivers for
both SoCs inside the same kernel is going to be really low.

Make a test, a build a kernel only for 9G20, another only for 9G25, and
another with both.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
