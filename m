From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 25 Nov 2014 07:51:07 +0100
Subject: [PATCHv3 09/16] ARM: mvebu: implement suspend/resume support
 for Armada XP
In-Reply-To: <20141123033603.GA9801@lunn.ch>
References: <1416585613-2113-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1416585613-2113-10-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141121164142.GB20238@lunn.ch>
 <20141121175957.6ef4f26d@free-electrons.com>
 <20141121172031.GC20238@lunn.ch>
 <20141122215648.771225f2@free-electrons.com>
 <20141123033603.GA9801@lunn.ch>
Message-ID: <20141125075107.16473bf1@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Sun, 23 Nov 2014 04:36:03 +0100, Andrew Lunn wrote:

> > No, it is not the BootROM that does this. It is the binary header,
> > which is something different.
> 
> O.K, so this definitely needs documenting somewhere, since it is not
> obvious. I'm not sure if it is sufficient to make this part of the
> commit log, or if it should be documented in Documentation/power.

I can send a follow-up patch that adds a more detailed comment in
arch/arm/mach-mvebu/pm.c maybe?

> > The "binary header" is currently the piece of code that we extract
> > using the kwbimage tool from existing U-Boot images to build working
> > Barebox images, since we haven't yet written the equivalent code in
> > Barebox land.
> 
> Is it a binary blob in the uboot source tree?

Originally, parts of it were available in the form of source code, and
only the code doing the DDR3 training to calculate the optimal timings
was provided as a binary blob. However, in order to allow the U-Boot
folks to add complete support for Armada XP, Marvell opened this part
as well. See
http://git.denx.de/?p=u-boot/u-boot-testing.git;a=shortlog;h=refs/heads/marvell-armada-xp-2014-09-29-spl.

> > So, the specification of where the "resume informations" is located and
> > how this information is organized is purely defined by software that
> > can potentially be changed, not by the BootROM. Though that if we
> > decided to use a different protocol, we would basically have a
> > suspend/resume in the kernel that would not work with any Marvell
> > platform  that uses the default bootloader.
> 
> It also makes mainline suspend/resume dependent on Marvell not
> changing the bootloader.

Yes, absolutely. Just like the suspend/resume mechanism also depends on
which firmware was installed in the PIC micro-controller that controls
the power rails.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
