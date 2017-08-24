From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 24 Aug 2017 12:43:26 -0700
Subject: [GIT PULL 1/6 V2] Broadcom soc changes for 4.14
In-Reply-To: <20170817183748.1450-1-f.fainelli@gmail.com>
References: <20170817183748.1450-1-f.fainelli@gmail.com>
Message-ID: <20170824194326.29202-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.14/soc

for you to fetch changes up to c9351923600e073083fc378c870c593cf98dd551:

  Merge tag 'bcm2835-soc-next-2017-08-24' into soc/next (2017-08-24 11:47:29 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoC arch/ changes for 4.14,
please pull the following:

- Danilo removes the clock provider driver stubs which are no longer needed
  now that we have a proper CPRMAN clock provider driver

- Stefan moves the SMP startup code for BCM2836 from the interrupt controller
  driver down to where it belongs in the architecture code, this was requested
  by Marc Zyngier before comitting any fixes to that code

- Phil provides a fix for a future Raspberry Pi firmware which will make the
  secondary cores wait for an event and therefore requires the CPU onlining
  other cores to send such event (along with the appropriate barrier)

----------------------------------------------------------------
Danilo Krummrich (1):
      clk: bcm2835: remove remains from stub clk driver

Florian Fainelli (1):
      Merge tag 'bcm2835-soc-next-2017-08-24' into soc/next

Phil Elwell (1):
      ARM: bcm2836: Send event when onlining other cores

Stefan Wahren (1):
      irqchip: bcm2836: Move SMP startup code to arch/arm (v2)

 arch/arm/mach-bcm/Makefile          |  5 +++
 arch/arm/mach-bcm/board_bcm2835.c   | 11 ++----
 arch/arm/mach-bcm/platsmp.c         | 38 ++++++++++++++++++
 arch/arm/mach-bcm/platsmp.h         | 10 +++++
 drivers/clk/bcm/clk-bcm2835-aux.c   |  1 -
 drivers/clk/bcm/clk-bcm2835.c       | 30 --------------
 drivers/irqchip/irq-bcm2836.c       | 79 +------------------------------------
 include/linux/clk/bcm2835.h         | 24 -----------
 include/linux/irqchip/irq-bcm2836.h | 70 ++++++++++++++++++++++++++++++++
 9 files changed, 129 insertions(+), 139 deletions(-)
 create mode 100644 arch/arm/mach-bcm/platsmp.h
 delete mode 100644 include/linux/clk/bcm2835.h
 create mode 100644 include/linux/irqchip/irq-bcm2836.h
