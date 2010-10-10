From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sun, 10 Oct 2010 20:40:37 +0300
Subject: [PATCH 0/3] staging: tidspbridge: fix ioremap() usage
Message-ID: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we truly reserve the memory so that the kernel doesn't map it.

Unfortunately, the ARM architecture code doesn't provide a good way to do this,
so I had to modify it a bit.

Felipe Contreras (3):
  arm: mm: allow boards to fiddle with meminfo
  omap: dsp: fix ioremap() usage
  staging: tidspbridge: remove memory consistency from TODO list

 arch/arm/include/asm/mach/arch.h         |    2 +-
 arch/arm/mm/init.c                       |    7 +++--
 arch/arm/plat-omap/common.c              |   43 +++++++++++++++++++++++++++--
 arch/arm/plat-omap/devices.c             |   30 ---------------------
 arch/arm/plat-omap/include/plat/common.h |    3 +-
 arch/arm/plat-omap/include/plat/dsp.h    |    6 ----
 drivers/staging/tidspbridge/TODO         |    1 -
 7 files changed, 47 insertions(+), 45 deletions(-)

-- 
1.7.3.1.2.g7fe2b
