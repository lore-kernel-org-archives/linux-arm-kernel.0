From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu, 23 May 2013 11:05:06 +0200
Subject: [RESEND PATCH 0/3] ARM: at91: move aic driver to drivers/irqchip
Message-ID: <1369299909-10078-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Sorry for the resend. This version is made using git format-patch -M.

This patch series move the at91 AIC (Advance Interrupt Controller)
driver to the irqchip subsystem directory (drivers/irqchip).

It also make use of IRQCHIP_DECLARE to register irqchip for dt boards
instead of using the machine specific "init_irq" function.

Finally it register the arch specific irq handler inside the the init
functions using set_handle_irq. This way we can remove all the machine
specific "handle_irq".

This patch series was tested on kizbox board (sam9g20 SoC) using
device tree. Could someone test it on other boards (both dt and non dt)?

Best Regards,
Boris

Boris BREZILLON (3):
  ARM: at91: move at91 aic driver to drivers/irqchip
  ARM: at91: use IRQCHIP_DECLARE instead of machine specific init_irq
  ARM: at91: use set_handle_irq instead of machine specific handle_irq

 arch/arm/mach-at91/Makefile                        |    2 +-
 arch/arm/mach-at91/at91rm9200.c                    |    2 +-
 arch/arm/mach-at91/at91sam9260.c                   |    2 +-
 arch/arm/mach-at91/at91sam9261.c                   |    2 +-
 arch/arm/mach-at91/at91sam9263.c                   |    2 +-
 arch/arm/mach-at91/at91sam9g45.c                   |    2 +-
 arch/arm/mach-at91/at91sam9rl.c                    |    2 +-
 arch/arm/mach-at91/at91x40.c                       |    2 +-
 arch/arm/mach-at91/board-1arm.c                    |    3 +--
 arch/arm/mach-at91/board-afeb-9260v1.c             |    3 +--
 arch/arm/mach-at91/board-cam60.c                   |    3 +--
 arch/arm/mach-at91/board-carmeva.c                 |    3 +--
 arch/arm/mach-at91/board-cpu9krea.c                |    3 +--
 arch/arm/mach-at91/board-cpuat91.c                 |    3 +--
 arch/arm/mach-at91/board-csb337.c                  |    3 +--
 arch/arm/mach-at91/board-csb637.c                  |    3 +--
 arch/arm/mach-at91/board-dt-rm9200.c               |   15 ++-------------
 arch/arm/mach-at91/board-dt-sam9.c                 |   16 ++--------------
 arch/arm/mach-at91/board-dt-sama5.c                |   16 ++--------------
 arch/arm/mach-at91/board-eb01.c                    |    4 ++--
 arch/arm/mach-at91/board-eb9200.c                  |    4 ++--
 arch/arm/mach-at91/board-ecbat91.c                 |    3 +--
 arch/arm/mach-at91/board-eco920.c                  |    3 +--
 arch/arm/mach-at91/board-flexibity.c               |    3 +--
 arch/arm/mach-at91/board-foxg20.c                  |    3 +--
 arch/arm/mach-at91/board-gsia18s.c                 |    3 +--
 arch/arm/mach-at91/board-kafa.c                    |    3 +--
 arch/arm/mach-at91/board-kb9202.c                  |    3 +--
 arch/arm/mach-at91/board-pcontrol-g20.c            |    3 +--
 arch/arm/mach-at91/board-picotux200.c              |    3 +--
 arch/arm/mach-at91/board-qil-a9260.c               |    3 +--
 arch/arm/mach-at91/board-rm9200dk.c                |    3 +--
 arch/arm/mach-at91/board-rm9200ek.c                |    3 +--
 arch/arm/mach-at91/board-rsi-ews.c                 |    4 ++--
 arch/arm/mach-at91/board-sam9-l9260.c              |    3 +--
 arch/arm/mach-at91/board-sam9260ek.c               |    3 +--
 arch/arm/mach-at91/board-sam9261ek.c               |    3 +--
 arch/arm/mach-at91/board-sam9263ek.c               |    3 +--
 arch/arm/mach-at91/board-sam9g20ek.c               |    4 +---
 arch/arm/mach-at91/board-sam9m10g45ek.c            |    3 +--
 arch/arm/mach-at91/board-sam9rlek.c                |    3 +--
 arch/arm/mach-at91/board-snapper9260.c             |    3 +--
 arch/arm/mach-at91/board-stamp9g20.c               |    4 +---
 arch/arm/mach-at91/board-usb-a926x.c               |    5 +----
 arch/arm/mach-at91/board-yl-9200.c                 |    3 +--
 arch/arm/mach-at91/generic.h                       |    5 -----
 arch/arm/mach-at91/{ => include/mach}/at91_aic.h   |    3 ---
 arch/arm/mach-at91/pm.c                            |    2 +-
 drivers/irqchip/Makefile                           |    1 +
 .../mach-at91/irq.c => drivers/irqchip/irq-at91.c  |   12 +++++++++++-
 50 files changed, 64 insertions(+), 131 deletions(-)
 rename arch/arm/mach-at91/{ => include/mach}/at91_aic.h (97%)
 rename arch/arm/mach-at91/irq.c => drivers/irqchip/irq-at91.c (97%)

-- 
1.7.9.5
