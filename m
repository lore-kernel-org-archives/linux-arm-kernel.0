From: joe@perches.com (Joe Perches)
Date: Sat, 11 Sep 2010 22:10:48 -0700
Subject: [PATCH 00/11] treewide: Remove pr_<level> uses with KERN_<level>
Message-ID: <cover.1284267142.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of these are pr_debug(KERN_<foo>.
pr_<level>(KERN_<level> is unnecessary.

Joe Perches (11):
  arch/arm: Remove pr_<level> uses of KERN_<level>
  arch/avr32: Remove pr_<level> uses of KERN_<level>
  arch/microblaze: Remove pr_<level> uses of KERN_<level>
  arch/mips: Remove pr_<level> uses of KERN_<level>
  arch/powerpc: Remove pr_<level> uses of KERN_<level>
  arch/x86: Remove pr_<level> uses of KERN_<level>
  drivers/infiniband: Remove pr_<level> uses of KERN_<level>
  drivers/net/skfp: Remove pr_<level> uses of KERN_<level>
  drivers/staging/msm: Remove pr_<level> uses of KERN_<level>
  drivers/usb/gadget: Remove pr_<level> uses of KERN_<level>
  sound: Remove pr_<level> uses of KERN_<level>

 arch/arm/mach-pxa/cpufreq-pxa2xx.c       |    3 +-
 arch/avr32/mach-at32ap/at32ap700x.c      |    4 +-
 arch/microblaze/kernel/exceptions.c      |   16 ++----
 arch/mips/kernel/irq-gic.c               |    2 +-
 arch/mips/pci/pci-rc32434.c              |    2 +-
 arch/powerpc/kvm/emulate.c               |    4 +-
 arch/powerpc/sysdev/pmi.c                |    2 +-
 arch/x86/kernel/apb_timer.c              |    4 +-
 drivers/infiniband/hw/amso1100/c2_intr.c |    4 +-
 drivers/net/skfp/skfddi.c                |   84 +++++++++++++++---------------
 drivers/staging/msm/staging-devices.c    |    2 +-
 drivers/usb/gadget/r8a66597-udc.c        |    2 +-
 sound/ppc/snd_ps3.c                      |    2 +-
 sound/soc/s3c24xx/s3c-dma.c              |    3 +-
 14 files changed, 64 insertions(+), 70 deletions(-)

-- 
1.7.3.rc1
