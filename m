From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Jan 2013 23:42:21 -0700
Subject: [GIT PULL 3/4] ARM: bcm2835: device tree updates
In-Reply-To: <1359441742-32647-1-git-send-email-swarren@wwwdotorg.org>
References: <1359441742-32647-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1359441742-32647-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SoC's SDHCI and MMC controllers are added to device tree, and enabled
in the Raspberry Pi board device tree. Some fixed clocks are added to the
device tree to support these drivers. These could be replaced by real
clocks in the future.

A hard-coded memreserve is removed from device tree; the bootloader should
specify the correct memory node content instead, since the memory layout
is dynamic.

This branch is based on v3.8-rc3.

----------------------------------------------------------------

The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-rpi.git bcm2835-for-3.9-dt

for you to fetch changes up to 9692c191ffffbd5255bec222b8f0f2854932a408:

  ARM: bcm2835: fix clock node aliasing in device tree

----------------------------------------------------------------

Stephen Warren (4):
      ARM: bcm2835 rpi: remove hard-coded memreserve from DT
      ARM: bcm2835: add SDHCI node to DT
      ARM: bcm2835: add I2C controllers to DT
      ARM: bcm2835: fix clock node aliasing in device tree

 arch/arm/boot/dts/bcm2835-rpi-b.dts |   16 ++++++++++-
 arch/arm/boot/dts/bcm2835.dtsi      |   44 ++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)
