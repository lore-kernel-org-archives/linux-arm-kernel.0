From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Aug 2012 11:46:36 +0100
Subject: [PATCH 0/6] Device Tree IRQ related enablement patches
Message-ID: <1344250002-6011-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set pertains to the addition of a new IRQ domain for
the DB8500-PRCMU and providing it with Interrupt Controller status
in the eyes of Device Tree. We also ensure that the Power-On-Key
driver obtains the correct IRQ when being probed with Device Tree
and otherwise.

 arch/arm/boot/dts/dbx5x0.dtsi      |    5 +++-
 drivers/input/misc/ab8500-ponkey.c |    6 ++--
 drivers/mfd/db8500-prcmu.c         |   54 +++++++++++++++++++++++++++---------
 drivers/mfd/mfd-core.c             |   10 +++++--
 include/linux/mfd/db8500-prcmu.h   |    2 ++
 5 files changed, 59 insertions(+), 18 deletions(-)
