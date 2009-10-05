From: mikpe@it.uu.se (Mikael Pettersson)
Date: Mon, 5 Oct 2009 17:15:55 +0200
Subject: [PATCH v1.0 2/4] TS72XX: Allow to override machine ID
In-Reply-To: <4AC9E3CE.2030307@techworks.ie>
References: <20091004011413.12578.89897.stgit@localhost.localdomain>
	<20091004011424.12578.79467.stgit@localhost.localdomain>
	<BD79186B4FD85F4B8E60E381CAEE190901DB75AB@mi8nycmail19.Mi8.com>
	<4AC9E3CE.2030307@techworks.ie>
Message-ID: <19146.3499.156615.1713@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christian Gagneraud writes:
 > H Hartley Sweeten wrote:
 > > On Saturday, October 03, 2009 6:14 PM, Christian Gagneraud wrote:
 > >> From: Matthieu Crapet <mcrapet@gmail.com>
 > >>
 > >> In early days Technologic Systems fixed the 0x163 value in redboot
 > >> instead of 0x2a1, this patch allow to overwrite it.
 > >>
 > >> Signed-off-by: Matthieu Crapet <mcrapet@gmail.com>
 > >> Signed-off-by: Christian Gagneraud <cgagneraud@techworks.ie>
 > > 
 > > As others have already pointed out, this is a pure hack and not
 > > suitable for mainline.
 > > 
 > > The bootloader for systems that needs this really should be updated.
 > > Machine ID 0x163 (355) is ARCH_CX861XX which isn't an ep93xx based
 > > system and doesn't even have a platform init in mainline.
 > 
 > I see your point, but what if the bootloader can't be updated? Does 
 > that mean that people using these boards will have to bother with 
 > applying patches on mainline kernel for ever?
 > Can't we find a way to address this issue, I'm pretty sure this is not 
 > the only board that need this kind of asm hack.

All you need to do is to wrap the kernel binary image with
a small shim that corrects the Machine ID in r1. devio can
do that, as can (I think) printf(1).

No need to replace the bootloader or hack the kernel.
