From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Apr 2012 11:43:52 +0100
Subject: [PATCH 0/16] Another round of Device Tree enablement for Snowball
Message-ID: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set enables the following devices:
     - External bus for Ethernet chip
     - SMSC9115 Ethernet chip
     - DB8500 PRCMU
     - DB8500 PRCMU Timer (Clocksource)

... and provides the following functionality:
     - Nomadik GPIO controller irqdomain support

... and fixes the following bugs:
     - Attempt to free a non-existent IRQ in SMSC911x
     - Attempt to probe non-existent devices on Snowball

.../devicetree/bindings/gpio/gpio-nmk.txt          |    2 +
 arch/arm/boot/dts/db8500.dtsi                      |   39 ++++++++++++++++++-
 arch/arm/boot/dts/snowball.dts                     |   40 ++++++++++----------
 arch/arm/mach-ux500/board-mop500.c                 |   38 ++++++++++++-------
 arch/arm/mach-ux500/board-mop500.h                 |    3 +
 arch/arm/mach-ux500/cpu-db8500.c                   |   33 ++++++++++++++++
 arch/arm/mach-ux500/cpu.c                          |    1 +
 arch/arm/mach-ux500/timer.c                        |   24 ++++++++++++
 drivers/gpio/gpio-nomadik.c                        |   40 ++++++++++++++++++-
 drivers/mfd/db8500-prcmu.c                         |   10 ++++-
 drivers/mmc/host/mmci.c                            |    5 +-
 drivers/net/ethernet/smsc/smsc911x.c               |    3 +-
 12 files changed, 192 insertions(+), 46 deletions(-)
