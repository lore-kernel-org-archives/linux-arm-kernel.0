From: pratheesh@ti.com (Pratheesh Gangadhar)
Date: Fri, 18 Feb 2011 20:35:28 +0530
Subject: [PATCH 0/2] Add PRUSS UIO driver support
Message-ID: <1298041530-26855-1-git-send-email-pratheesh@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add support for PRUSS (Programmable Real-time Unit Sub System) UIO driver in Texas Instruments DA850, AM18xx and OMAPL1-38 processors. PRUSS is programmable RISC core which can be used to implement Soft IPs (eg:- DMA, CAN, UART,SmartCard) and Industrial communications data link layers (eg:- PROFIBUS). UIO driver exposes PRUSS resources like memory and interrupts to user space application.PRUSS UIO application API can be used to control PRUs in PRUSS, setup PRU INTC, load firmware to PRUs and implement IPC between Host processor and PRUs. More information on PRUSS and UIO linux user space API available in the links below

http://processors.wiki.ti.com/index.php/Programmable_Realtime_Unit_Subsystem
http://processors.wiki.ti.com/index.php/PRU_Linux_Application_Loader
http://processors.wiki.ti.com/index.php/PRU_Linux_Application_Loader_API_Guide 

PRUSS UIO driver support patch applies on top of Linus's tree latest.
Both patches applies on top of linux-davinci tree latest. 

Pratheesh Gangadhar (2):
  PRUSS UIO driver support
  Defines DA850/AM18xx/OMAPL1-38 SOC resources used by PRUSS UIO driver

 arch/arm/mach-davinci/board-da850-evm.c    |    4 +
 arch/arm/mach-davinci/da850.c              |   35 ++++
 arch/arm/mach-davinci/devices-da8xx.c      |   73 ++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    3 +
 drivers/uio/Kconfig                        |   10 +
 drivers/uio/Makefile                       |    1 +
 drivers/uio/uio_pruss.c                    |  250 ++++++++++++++++++++++++++++
 7 files changed, 376 insertions(+), 0 deletions(-)
 create mode 100644 drivers/uio/uio_pruss.c
