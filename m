From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 3 Aug 2017 01:05:21 +0800
Subject: [PATCH 0/2] serial: 8250: add support for MediaTek BTIF controller
Message-ID: <cover.1501692369.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

This patchset introduces the support for MediaTek BTIF controller.

MediaTek BTIF controller is the serial interface similar to UART but it
works only as the digital device which is mainly used to communicate with
the connectivity module also called CONNSYS inside the SoC which could be
mostly found on those MediaTek SoCs with Bluetooth feature.

And the controller is made as being compatible with the 8250 register
layout so it tends to be integrated with existing 8250 core driver and
have no requirement for the modem configuration additionally such as the
baud rate calculation and assignment.

Sean Wang (2):
  dt-bindings: serial: Add MediaTek BTIF controller bindings
  tty: serial: 8250: Add MediaTek BTIF controller on MT7622 and MT7623
    SoC

 .../devicetree/bindings/serial/mtk-btif.txt        |  26 +++
 drivers/tty/serial/8250/8250_btif.c                | 224 +++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig                    |   9 +
 drivers/tty/serial/8250/Makefile                   |   1 +
 4 files changed, 260 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/mtk-btif.txt
 create mode 100644 drivers/tty/serial/8250/8250_btif.c

-- 
2.7.4
