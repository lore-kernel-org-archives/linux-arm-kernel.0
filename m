From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 12 Jan 2015 21:08:20 +0800
Subject: [PATCH v2 0/4] tty: serial: Add earlycon support to MT8173 SoC 
Message-ID: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

8250 earlycon will always init serial hardware. The hardware setting is
from kernel earlycon parameters or by probe current baudrate. I add noinit
options in 8250 earlycon to bypass init, such that earlycon can use the
same hardware setting as loader.

This series also add MT8173 earlycon support, and stdout in device
tree.

Change v2:
1. Add noinit options.
2. Remove duplicate code in 8250_mtk.c, reuse the 8250_early.c existed function.

This patchset is based on 3.19-rc1, and my basic support for Mediatek
MT8173 SoC [1].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315165.html

Eddie Huang (4):
  tty: serial: Add 8250 earlycon to support noinit option
  tty: serial: 8250_mtk: Add earlycon
  arm64: dts: Add mediatek MT8173 earlycon support
  Document: Modify 8250 earlycon kernel parameters

 Documentation/kernel-parameters.txt         |  5 ++++-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts |  4 +++-
 drivers/tty/serial/8250/8250_early.c        |  7 ++++---
 drivers/tty/serial/8250/8250_mtk.c          | 15 +++++++++++++++
 drivers/tty/serial/earlycon.c               | 17 ++++++++++++-----
 include/linux/serial_8250.h                 |  2 ++
 include/linux/serial_core.h                 |  1 +
 7 files changed, 41 insertions(+), 10 deletions(-)

--
1.8.1.1.dirty
