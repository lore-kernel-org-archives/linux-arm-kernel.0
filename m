From: nico@linaro.org (Nicolas Pitre)
Date: Mon, 12 Aug 2013 15:44:03 -0400 (EDT)
Subject: [Git pull request] big.LITTLE switcher core support
Message-ID: <alpine.LFD.2.03.1308121517410.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, would you please pull the following:

   git://git.linaro.org/people/nico/linux iks_for_rmk

This is the first part of the patch series adding IKS (In-Kernel 
Switcher) support for big.LITTLE system architectures.  This consists of 
the core patches only.  Extra patches to come later will introduce 
various optimizations and tracing support.

Those patches were posted on the list a while ago here:

   http://news.gmane.org/group/gmane.linux.ports.arm.kernel/thread=253942

All review comments so far have been addressed.

This is based on v3.11-rc3. The diffstat follows:

 arch/arm/Kconfig                       |  26 ++
 arch/arm/common/Makefile               |   2 +
 arch/arm/common/bL_switcher.c          | 606 +++++++++++++++++++++++++++
 arch/arm/common/bL_switcher_dummy_if.c |  71 ++++
 arch/arm/include/asm/bL_switcher.h     |  17 +
 arch/arm/kernel/sleep.S                |  26 +-
 arch/arm/kernel/suspend.c              |   8 +-
 drivers/irqchip/irq-gic.c              | 108 ++++-
 include/linux/irqchip/arm-gic.h        |   5 +
 9 files changed, 848 insertions(+), 21 deletions(-)


Nicolas
