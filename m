From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 13:26:55 +0100
Subject: [PATCH 0/3]  Support for the ARM Cortex-R7 Processor
Message-ID: <1368534418-11287-1-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds initial support for the ARM Cortex-R7 Processor. The R7 is an
SMP-capable R-class device. Among other things, R-Class cores differ from the
A-class in using a Memory Protection Unity (MPU) instead of an MMU.

Support for the MPU is required in order to use the R7 in an SMP configuration.
There are patches for MPU support that will be posted to this list shortly.

This series depends on:
 - The nommu fixes series I posted to this list earlier
   - http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/168114.html
 - The ARCH_MULTIPLATFORM restructuring that I posted earlier in order to
   be able to use ARCH_VEXPRESS with NOMMU.
   - http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/168106.html

This code is available in my r7 branch:
http://www.linux-arm.org/git?p=linux-ja.git;a=log;h=refs/heads/r7

Jonathan Austin (3):
  ARM: select CPU_CPU15_MMU/MPU appropriately
  ARM: add Cortex-R7 Processor Info
  ARM: vexpress: Add Cortex-R Series UART, selectable via DEBUG_LL

 arch/arm/Kconfig.debug            |   10 +++++++++-
 arch/arm/include/debug/vexpress.S |   10 ++++++++++
 arch/arm/mm/Kconfig               |    3 ++-
 arch/arm/mm/proc-v7.S             |   13 ++++++++++++-
 4 files changed, 33 insertions(+), 3 deletions(-)

-- 
1.7.9.5
