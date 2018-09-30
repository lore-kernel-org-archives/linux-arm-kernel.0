From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 30 Sep 2018 20:07:12 +0200
Subject: [GIT PULL] arm: actions: dt64 for v4.20 #1
In-Reply-To: <20180930180715.25829-1-afaerber@suse.de>
References: <20180930180715.25829-1-afaerber@suse.de>
Message-ID: <20180930180715.25829-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

Here's my dt64 pull for Actions Semi.
It includes a topic branch for S900 SPS.

Regards,
Andreas

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm64-dt-for-4.20

for you to fetch changes up to 01463ac63b53e24e4e315aa9c5f091e9e0342ad4:

  arm64: dts: actions: s700: Set UART clock references from CMU (2018-09-30 18:57:23 +0200)

----------------------------------------------------------------
Actions Semi arm64 based SoC DT for v4.20

This updates SPDX headers for remaining files.

For S900 it adds clock, pinctrl, i2c and dma nodes.
S900 SPS is added via topic branch (shared with driver).

For S700 it adds clock nodes.

----------------------------------------------------------------
Andreas F?rber (2):
      arm64: dts: actions: Convert to new-style SPDX license identifiers
      Merge branch 'v4.20/s900-sps-bindings' into v4.20/dt64

Manivannan Sadhasivam (10):
      dt-bindings: power: Add Actions Semi S900 SPS
      arm64: dts: actions: s900: Add Clock Management Unit nodes
      arm64: dts: actions: s900: Source CMU clock for UARTs
      arm64: dts: actions: s900: Add SPS node
      arm64: dts: actions: s900: Add pinctrl node
      arm64: dts: actions: s900: Add gpio properties to pinctrl node
      arm64: dts: actions: s900-bubblegum-96: Add gpio line names
      arm64: dts: actions: s900: Add I2C controller nodes
      arm64: dts: actions: s900-bubblegum-96: Enable I2C1 and I2C2
      arm64: dts: actions: s900: Add DMA Controller

Saravanan Sekar (2):
      arm64: dts: actions: s700: Add Clock Management Unit
      arm64: dts: actions: s700: Set UART clock references from CMU

 .../devicetree/bindings/power/actions,owl-sps.txt  |   2 +
 arch/arm64/boot/dts/actions/Makefile               |   2 +
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts   |   7 -
 arch/arm64/boot/dts/actions/s700.dtsi              |  21 ++
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts  | 224 ++++++++++++++++++++-
 arch/arm64/boot/dts/actions/s900.dtsi              | 118 ++++++++++-
 include/dt-bindings/power/owl-s900-powergate.h     |  23 +++
 7 files changed, 381 insertions(+), 16 deletions(-)
 create mode 100644 include/dt-bindings/power/owl-s900-powergate.h
