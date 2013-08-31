From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Sat, 31 Aug 2013 16:57:40 +1200
Subject: Query about include/linux/mailbox.h
Message-ID: <522177C4.8060205@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

At the end of all this, my question is should I put the BCM2835 mailbox 
driver in drivers somewhere, and try to make use of 
include/linux/mailbox.h, or should go with the view that mailbox drivers 
are inherently machine specific, have no common driver framework, and 
belongs in arch/arm/mach-bcm2835?

The background to this is that I'm trying to help bring Raspberry Pi 
support into the mainline kernel. Lubomir Rintel coded a mailbox driver 
[1] that I liked the look off and want to fix up and push upstream. 
Stephen Warren suggested that Lubmir's patch had the benefit of using a 
new mailbox sub-system [2] and that I should have a look at that.

I've looked at include/linux/mailbox.h, and it only has 3 function 
declarations, which are all specific to the PL320.  Unless there is 
something I've missed, then there is no mailbox sub-system to speak of. 
  Just a header file that will quickly a dependency nightmare.

I found a patch submission series from Jassi Brar [3] that looks like 
the start of an actual mailbox framework, but there is no indication of 
it in the current kernel source.  I assume it was dropped for some reason.

I don't see much benefit to a mailbox sub-system.  The BCM2835 one is 
quite a small piece of code, and I really see it as a machine-specific 
layer for other device drivers that implement a standard sub-system 
interface, like framebuffers.

Which all leads back to my opening question - which way do I jump? What 
I'd prefer to do is submit arch/arm/mach-bcm2835.c etc, and maybe even a 
patch to move include/linux/mailbox.h somewhere less inviting.

Cheers,
Craig.


[1] 
http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-April/000528.html
[2] 
http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-May/000546.html
[3] http://lkml.indiana.edu/hypermail/linux/kernel/1305.0/01978.html
