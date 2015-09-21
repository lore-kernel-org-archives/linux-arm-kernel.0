From: slash.tmp@free.fr (Mason)
Date: Mon, 21 Sep 2015 17:00:08 +0200
Subject: Steps to submit a new arch/arm port
Message-ID: <56001B78.2090001@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

I've been working on an arch/arm port for some time. I've removed
a lot of non-essential code, and currently, what I have is:

$ git diff --stat v4.2 my4.2
 Makefile                                               |    4 +-
 arch/arm/Kconfig                                       |   26 ++
 arch/arm/Makefile                                      |    1 +
 arch/arm/boot/dts/Makefile                             |    1 +
 arch/arm/boot/dts/tango.dts                            |   96 ++++++++
 arch/arm/kernel/smp_twd.c                              |    3 +-
 arch/arm/mach-tangox/Kconfig                           |   57 +++++
 arch/arm/mach-tangox/Makefile                          |   10 +
 arch/arm/mach-tangox/Makefile.boot                     |    3 +
 arch/arm/mach-tangox/clock-tangox.c                    |  134 ++++++++++
 arch/arm/mach-tangox/io.c                              |   18 ++
 arch/arm/mach-tangox/setup.c                           |   22 ++
 arch/arm/tools/mach-types                              |    1 +
 drivers/irqchip/Makefile                               |    1 +
 drivers/irqchip/irq-tangox.c                           |  234 ++++++++++++++++++
 drivers/net/ethernet/Kconfig                           |    1 +
 drivers/net/ethernet/Makefile                          |    1 +
 drivers/net/ethernet/sigmadesigns/Kconfig              |    7 +
 drivers/net/ethernet/sigmadesigns/Makefile             |    5 +
 drivers/net/ethernet/sigmadesigns/tangox/Kconfig       |   21 ++
 drivers/net/ethernet/sigmadesigns/tangox/Makefile      |    5 +
 drivers/net/ethernet/sigmadesigns/tangox/tangox_enet.c | 1158 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ethernet/sigmadesigns/tangox/tangox_enet.h |  257 +++++++++++++++++++
 drivers/tty/serial/8250/8250_core.c                    |    8 +-
 drivers/tty/serial/of_serial.c                         |    2 +-
 25 files changed, 2066 insertions(+), 10 deletions(-)

(The two drivers (irqchip and ethernet) are from Mans Rullgard's tree.)

TODO
Convert the clock registration code to device tree
Add PHY ISR to ethernet driver


Could you provide some pointers/links and guidance detailing the
steps required to submit a new port under arch/arm?
(With the current requirements: DT, ARCH_MULTIPLATFORM, etc)

Open questions:

1) Linux kernel runs in non-secure world. The port used to tweak
L2 cache configuration via custom SMC calls to the OS running in
secure world. I've removed that for now.
Is there a standard solution these days?

2) For now, only one core is enabled. The other core is supposed
to be enabled via custom SMC calls. Is there a standard solution
these days? A few months ago, ARM engineers suggested PSCI.
Are modern ports using that?


Regards.
