From: tony@atomide.com (Tony Lindgren)
Date: Fri, 15 Jan 2010 17:35:07 -0800
Subject: [PATCH 0/4] omap multiboot improvments for merge window after 2.6.34
Message-ID: <20100116013205.10065.95921.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some multiboot improvments for review. These patches
are intended for the 2.6.34 merge window.

Comments and testing would be nice, I've tested them so far
on osk, 770, n800, rx51 and overo.

Regards,

Tony

---

Tony Lindgren (4):
      omap: Clean the serial port defines
      omap: Make uncompress code and DEBUG_LL code generic
      omap: Remove old DEBUG_LL serial port options
      omap: Make get_irqnr_and_base common for mach-omap2 multiboot


 arch/arm/mach-omap1/include/mach/debug-macro.S |   83 ++++++++++--
 arch/arm/mach-omap1/serial.c                   |   18 ++-
 arch/arm/mach-omap2/include/mach/debug-macro.S |   91 +++++++++----
 arch/arm/mach-omap2/include/mach/entry-macro.S |   55 +++++---
 arch/arm/mach-omap2/serial.c                   |   26 +++-
 arch/arm/plat-omap/Kconfig                     |   19 ---
 arch/arm/plat-omap/common.c                    |   18 +++
 arch/arm/plat-omap/include/plat/common.h       |    5 +
 arch/arm/plat-omap/include/plat/serial.h       |   62 ++++++---
 arch/arm/plat-omap/include/plat/uncompress.h   |  168 +++++++++++++++++-------
 10 files changed, 390 insertions(+), 155 deletions(-)

-- 
Signature
