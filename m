From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Sep 2012 08:09:58 +0000
Subject: [PATCH 22/24] scsi: eesox: use __iomem pointers for MMIO
In-Reply-To: <20120917220334.GU12245@n2100.arm.linux.org.uk>
References: <201209150800.35605.arnd@arndb.de>
 <201209151030.44105.arnd@arndb.de>
 <20120917220334.GU12245@n2100.arm.linux.org.uk>
Message-ID: <201209180809.58542.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 September 2012, Russell King - ARM Linux wrote:
> In both of my replies, I've said "as x86 does".  We need to follow
> x86's behaviour here, which is as I've quoted - it's not a matter
> that "I need to make up my mind" - my mind is already well made up.
> That is, we need to follow x86 here.
> 
> That is, const volatile void __iomem * for reads, and volatile void
> __iomem * for writes.

Ok, I'll keep the patch in the series then, as it only changes the
pointer that we do an MMIO write on, not the ones for MMIO read.

	Arnd
