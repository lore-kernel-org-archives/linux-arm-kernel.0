From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Feb 2013 11:55:19 +0000
Subject: [PATCH 04/17] ARM: Add ARCH_SUPPORTS_BIG_ENDIAN
In-Reply-To: <1360365467-25056-5-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-5-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130209115519.GB17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 11:17:34PM +0000, Ben Dooks wrote:
> Add ARCH_SUPPORTS_BIG_ENDIAN define to arch/arm/Kconfig. Since it used
> to live in arch/arm/mach-ixp4xx/Kconfig we move it up to the ARM one
> as the next best place for it.
> 
> It may be that it could be moved to a more generic location, with the
> other ARCH_SUPPORT functions.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

So in patch 3, you remove this option (which removes it from the generated
configs) and add it back in in the following patch.  This makes this series
non-bisectable.  Please roll this into patch 3 and update the patch
description accordingly.

I'd also suggest moving it to arch/arm/mm/Kconfig rather than
arch/arm/Kconfig, just before its only user, CPU_BIG_ENDIAN.
