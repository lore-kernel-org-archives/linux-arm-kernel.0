From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 3 Feb 2014 18:28:25 -0500
Subject: [RFC/RFT 0/2] ARM: mm: Introduce arch hooks for dma address
 translation
Message-ID: <1391470107-15927-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently arch specific DMA address translation routines can be enabled
using only defines wtth "mach/memory.h" which makes impossible to use them
in with multi-platform, single zImage builds.

Hence, introduce arch specific hooks for DMA address translations
routines to be compatible with multi-platform builds. In case if
an architecture won't use it - DMA address translation routines
will fall-back to existing implementation.

Series updates existing machines like omap1, ks8695, iop13xx to
use new DMA hooks.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Greg Ungerer <gerg@uclinux.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
CC: Grygorii Strashko <grygorii.strashko@ti.com>

Santosh Shilimkar (2):
  ARM: mm: introduce arch hooks for dma address translation routines
  ARM: keystone: Install hooks for dma address translation routines

 arch/arm/include/asm/dma-mapping.h          |   25 +++--------
 arch/arm/mach-iop13xx/include/mach/memory.h |   61 ---------------------------
 arch/arm/mach-iop13xx/setup.c               |   58 +++++++++++++++++++++++++
 arch/arm/mach-keystone/keystone.c           |   31 ++++++++++++++
 arch/arm/mach-ks8695/cpu.c                  |   50 ++++++++++++++++++++++
 arch/arm/mach-ks8695/include/mach/memory.h  |   33 ---------------
 arch/arm/mach-omap1/include/mach/memory.h   |   39 -----------------
 arch/arm/mach-omap1/io.c                    |   52 +++++++++++++++++++++++
 arch/arm/mm/dma-mapping.c                   |   29 +++++++++++++
 9 files changed, 226 insertions(+), 152 deletions(-)

-- 
1.7.9.5
