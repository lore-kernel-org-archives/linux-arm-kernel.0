From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 28 Apr 2011 18:50:15 -0400
Subject: [PATCH 0/9] zImage fixes
Message-ID: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a resent of some patches that were posted before, plus a couple
new ones.  They were reshuffled a bit so the most important ones appear
first.

This can be pulled from the following Git repository:

	git://git.linaro.org/people/nico/linux zImage_fixes

this is based on v2.6.39-rc1.  This contains:

[PATCH 1/9] ARM: zImage: make sure the stack is 64-bit aligned
[PATCH 2/9] ARM: zImage: Fix bad SP address after relocating kernel
[PATCH 3/9] ARM: zImage: make sure not to relocate on top of the relocation code
[PATCH 4/9] ARM: zImage: the page table memory must be considered before relocation

Russell: if you like those patches and pull them, I think those 4
commits should be merged in your "fixes" branch and go to Linus for the
next -rc.  The rest may appear into linux-next and wait for the next merge
window:

[PATCH 5/9] ARM: zImage: no need to get the decompressed size from the filesystem
[PATCH 6/9] ARM: zImage: simplify decompress_kernel()
[PATCH 7/9] ARM: zImage: don't ignore error returned from decompress()
[PATCH 8/9] ARM: zImage: remove the static qualifier from global data variables
[PATCH 9/9] ARM: zImage: make sure no GOTOFF relocs are used with .bss symbols

The diffstat for the entire series is:

 arch/arm/boot/compressed/Makefile               |   19 +++++-
 arch/arm/boot/compressed/decompress.c           |    4 +-
 arch/arm/boot/compressed/head.S                 |   55 ++++++++++++-----
 arch/arm/boot/compressed/misc.c                 |   24 +++----
 arch/arm/boot/compressed/vmlinux.lds.in         |    1 +
 arch/arm/mach-davinci/include/mach/uncompress.h |    5 +-
 arch/arm/mach-gemini/include/mach/uncompress.h  |    2 +-
 arch/arm/mach-iop32x/include/mach/uncompress.h  |    2 +-
 arch/arm/mach-iop33x/include/mach/uncompress.h  |    2 +-
 arch/arm/mach-ixp4xx/include/mach/uncompress.h  |    2 +-
 arch/arm/mach-mmp/include/mach/uncompress.h     |    2 +-
 arch/arm/mach-mxs/include/mach/uncompress.h     |    2 +-
 arch/arm/mach-ns9xxx/include/mach/uncompress.h  |    2 +-
 arch/arm/mach-nuc93x/include/mach/uncompress.h  |    2 +-
 arch/arm/mach-pxa/include/mach/uncompress.h     |    6 +-
 arch/arm/mach-rpc/include/mach/uncompress.h     |   12 ++--
 arch/arm/mach-s5p64x0/include/mach/uncompress.h |    6 +-
 arch/arm/mach-ux500/include/mach/uncompress.h   |    2 +-
 arch/arm/mach-w90x900/include/mach/uncompress.h |    2 +-
 arch/arm/plat-mxc/include/mach/uncompress.h     |    2 +-
 arch/arm/plat-omap/include/plat/uncompress.h    |    4 +-
 arch/arm/plat-samsung/include/plat/uncompress.h |    4 +-
 22 files changed, 98 insertions(+), 64 deletions(-)

Nicolas
