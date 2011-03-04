From: pratheesh@ti.com (Pratheesh Gangadhar)
Date: Sat,  5 Mar 2011 04:30:16 +0530
Subject: [PATCH v11 0/1] Add PRUSS UIO driver support
Message-ID: <1299279617-21108-1-git-send-email-pratheesh@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add support for PRUSS (Programmable Real-time Unit Sub
System) UIO driver in Texas Instruments DA850, AM18xx and OMAP-L138 processors.
PRUSS is programmable RISC core which can be used to implement Soft IPs
(eg:- DMA, CAN, UART,SmartCard) and Industrial communications data link layers
(eg:- PROFIBUS). UIO driver exposes PRUSS resources like memory and interrupts
to user space application.PRUSS UIO application API can be used to control PRUs
in PRUSS, setup PRU INTC, load firmware to PRUs and implement IPC between Host
processor and PRUs. More information on PRUSS and UIO linux user space API
available in the links below

http://processors.wiki.ti.com/index.php/Programmable_Realtime_Unit_Subsystem
http://processors.wiki.ti.com/index.php/PRU_Linux_Application_Loader
http://processors.wiki.ti.com/index.php/PRU_Linux_Application_Loader_API_Guide

Platform/board specific portion of this patch depends on Mistral patches below

[PATCH 1/1] davinci: changed SRAM allocator to shared ram :
				https://patchwork.kernel.org/patch/549351/
[PATCH 1/1] da830: macro rename DA8XX_LPSC0_DMAX to DA8XX_LPSC0_PRUSS :
				 https://patchwork.kernel.org/patch/549331/
[PATCH v2 01/13] mfd: pruss mfd driver :
				https://patchwork.kernel.org/patch/549531/
[PATCH v2 02/13] da850: pruss platform specific additions :
				https://patchwork.kernel.org/patch/549521/

I will submit a seperate patch set on top of these patches to support PRUSS
UIO driver.

Pratheesh Gangadhar (1):
  PRUSS UIO driver support

 drivers/uio/Kconfig                     |   17 ++
 drivers/uio/Makefile                    |    1 +
 drivers/uio/uio_pruss.c                 |  247 +++++++++++++++++++++++++++++++
 include/linux/platform_data/uio_pruss.h |   25 +++
 4 files changed, 290 insertions(+), 0 deletions(-)
 create mode 100644 drivers/uio/uio_pruss.c
 create mode 100644 include/linux/platform_data/uio_pruss.h
