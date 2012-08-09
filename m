From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  9 Aug 2012 16:53:47 +0100
Subject: [PATCH 0/8] Changes surrounding IRQs and IRQ domains 
Message-ID: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we apply some fixes to the way the AB8500 handles IRQs and
provide the DB8500 with an IRQ domain. We also handle hwirq to
virq conversion slightly differently when registering MFD devices.
The other changes pertain to the way IRQs are requested and dealt
with by AB8500 child devices.

 arch/arm/boot/dts/dbx5x0.dtsi      |    3 ++
 drivers/input/misc/ab8500-ponkey.c |    4 +--
 drivers/mfd/ab8500-core.c          |    3 +-
 drivers/mfd/db8500-prcmu.c         |   54 +++++++++++++++++++++++++++---------
 drivers/mfd/mfd-core.c             |    2 +-
 include/linux/mfd/db8500-prcmu.h   |    2 ++
 include/linux/of_irq.h             |    5 ++++
 kernel/irq/irqdomain.c             |    7 +++++
 8 files changed, 63 insertions(+), 17 deletions(-)
