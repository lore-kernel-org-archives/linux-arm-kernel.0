From: jwboyer@fedoraproject.org (Josh Boyer)
Date: Sat, 16 Nov 2013 09:56:24 -0500
Subject: xen drivers fail to link on ARM with v3.12-9888-gf63c482
Message-ID: <CA+5PVA7YMMRmFE=T7MOdGNeUiv_4Eu_u2-SrDfSTE052MpAnag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

The xen-gntalloc, xen-netfront, xen-blkfront, and xen-netback drivers
fail to link on ARM today with the following error:

ERROR: "phys_to_mach" [drivers/xen/xen-gntalloc.ko] undefined!
ERROR: "phys_to_mach" [drivers/net/xen-netfront.ko] undefined!
ERROR: "phys_to_mach" [drivers/net/xen-netback/xen-netback.ko] undefined!
ERROR: "phys_to_mach" [drivers/block/xen-blkfront.ko] undefined!

This is with Linus' tree as of this morning.

I'm guessing this is because the mfn_to_pfn and pfn_to_mfn functions
are inlined and reference phys_to_mach directly, and that isn't
exported to modules.  Thoughts?

josh
