From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 30 Sep 2013 22:40:24 -0400 (EDT)
Subject: [PATCH RESEND] ARM: add dtbImage.<dt> and dtbuImage.<dt> rules
In-Reply-To: <CA+bK7J7=x6=ZsWnSkGByvDLbht9nD6G3wQ5d05P-D96v6udDgg@mail.gmail.com>
References: <504DFBBF.5010202@free-electrons.com>
 <1348733441-11626-1-git-send-email-richard.genoud@gmail.com>
 <20120927082955.GR17667@game.jcrosoft.org>
 <CACQ1gAgwv4pBFZBrVZiWM2_=OneUO-s16LufSENx27gMC3DUig@mail.gmail.com>
 <52416F97.802@keymile.com> <20130924120152.GI11119@titan.lakedaemon.net>
 <20130924121939.GD12758@n2100.arm.linux.org.uk>
 <CA+bK7J7=x6=ZsWnSkGByvDLbht9nD6G3wQ5d05P-D96v6udDgg@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1309302230440.6331@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Sep 2013, Tim Bird wrote:

> What is the long-term mechanism/methodology for creating a kernel
> that runs on a single system?  So many drivers now have device-tree
> dependencies that it seems unlikely we'll be able to avoid using
> device tree.  But if we don't care or don't want to support more than
> a single platform, what should we do (if appending DTB to the zImage
> will eventually go away).  Will the requirement be that all future
> Linux bootloaders will be DT-aware?

The ability to append a DTB to zImage is not going away tomorrow, 
although I encourage you to use another solution if possible.

What can be done on a simple single platform setup is to load the DTB 
from flash into RAM just like another blob along with the ramdisk image 
and the zImage itself.  Then you just have to branch into zImage with 
the address of the DTB in RAM into r2.  Most bootloaders are able to 
load arbitrary binaries into memory, and most bootloaders (except for 
U-Boot) are able to set arbitrary values into r0-r3 before branching to 
some location in memory.


Nicolas
