From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 07 May 2011 00:26:00 -0400 (EDT)
Subject: Git pull request: zImage fixes
Message-ID: <alpine.LFD.2.00.1105070011540.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please pull:

	git://git.linaro.org/people/nico/linux zImage_fixes

this is based on v2.6.39-rc1.  This contains the same set of patches 
that were posted before, with Acked-by/Tested-by tags added and a minor 
Thumb2 compatibility fix.

You may pull the whole branch for the next merge window.  I'd suggest 
that you also merge commit ea9df3b168 into your "fixes" branch and send 
that to Linus before final 2.6.39, which consists of the first 4 patches 
fixing bugs in the current code.

[PATCH 1/9] ARM: zImage: make sure the stack is 64-bit aligned
[PATCH 2/9] ARM: zImage: Fix bad SP address after relocating kernel
[PATCH 3/9] ARM: zImage: make sure not to relocate on top of the relocation code
[PATCH 4/9] ARM: zImage: the page table memory must be considered before relocation

Up to here the diffstat is:

 arch/arm/boot/compressed/Makefile       |    2 +-
 arch/arm/boot/compressed/head.S         |   35 +++++++++++++++++--------
 arch/arm/boot/compressed/vmlinux.lds.in |    1 +
 3 files changed, 26 insertions(+), 12 deletions(-)

[PATCH 5/9] ARM: zImage: no need to get the decompressed size from the filesystem
[PATCH 6/9] ARM: zImage: simplify decompress_kernel()
[PATCH 7/9] ARM: zImage: don't ignore error returned from decompress()
[PATCH 8/9] ARM: zImage: remove the static qualifier from global data variables
[PATCH 9/9] ARM: zImage: make sure no GOTOFF relocs are used with .bss symbols

The diffstat for the entire series is:

 arch/arm/boot/compressed/Makefile               |   19 +++++-
 arch/arm/boot/compressed/decompress.c           |    4 +-
 arch/arm/boot/compressed/head.S                 |   57 ++++++++++++-----
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
 22 files changed, 100 insertions(+), 64 deletions(-)


Nicolas
