From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Jan 2011 13:57:26 -0000
Subject: [PATCH 02/14] ARM: bitops: switch set/clear/change bitops to	use
	ldrex/strex
In-Reply-To: <20110123001636.GA20841@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>	<E1Peue4-0003SN-Gk@rmk-PC.arm.linux.org.uk>
	<20110123001636.GA20841@n2100.arm.linux.org.uk>
Message-ID: <000601cbbc97$cc6955d0$653c0170$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Hopefully this isn't too late to be useful.

> On Mon, Jan 17, 2011 at 07:21:40PM +0000, Russell King - ARM Linux wrote:
> > Switch the set/clear/change bitops to use the word-based exclusive
> > operations, which are only present in a wider range of ARM architectures
> > than the byte-based exclusive operations.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> As only one person replied to this patch with test information, I'm
> not happy to push this into -rc, and hence that prevents it going into
> -stable too.  That means omap2plus_defconfig .38 mainline kernels
> (including -stable) will remain potentially dangerous when run on
> SMP capable hardware.
> 
> Therefore, I see no alternative at the moment but to purposely cause
> builds which cover ARMv6, and ARMv6K or ARMv7 CPUs to save people from
> data corruption.
> 
> Please get your tested-by's to me for at least the first three patches
> of this series ASAP.

I've tested this on the Versatile Express (ca9x4, little endian) with a USB
hard drive and ext3 (rw) filesystem. I did a bunch of parallel dds of a 2GB
file containing random data whilst the system was fairly loaded. File checksums
all passed and the kernel didn't do anything untowards.

Tested-by: Will Deacon <will.deacon@arm.com>

I appreciate this is the same test configuration as the one Nicolas did,
but it at least replicates his findings.

Will
