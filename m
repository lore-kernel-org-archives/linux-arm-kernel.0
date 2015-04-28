From: eddie.huang@mediatek.com (Eddie Huang)
Date: Tue, 28 Apr 2015 21:40:31 +0800
Subject: [PATCH v3 0/3] tty: serial: Add earlycon support to MT8173 SoC 
Message-ID: <1430228434-31779-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add earlycon support to MT8173 SoC platform.
To use earlycon, need
1. Add earlycon in boot parameters
2. Add "linux,sdtout-path" property in device tree file

This patch based on 4.1-rc1.

Change in v3:
Remove noinit options, not necessary, because 8250_early.c will not init hardware
if not provide baudrate.

Change v2:
1. Add noinit options.
2. Remove duplicate code in 8250_mtk.c, reuse the 8250_early.c existed function.

Eddie Huang (3):
  tty: serial: 8250: export early_serial8250_setup function
  tty: serial: 8250_mtk: Add earlycon
  arm64: dts: Add mediatek MT8173 earlycon support

 arch/arm64/boot/dts/mediatek/mt8173-evb.dts |  4 +++-
 drivers/tty/serial/8250/8250_early.c        |  2 +-
 drivers/tty/serial/8250/8250_mtk.c          | 13 +++++++++++++
 include/linux/serial_8250.h                 |  2 ++
 4 files changed, 19 insertions(+), 2 deletions(-)

-- 
1.8.1.1.dirty
