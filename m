From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 22 Oct 2014 21:12:06 +0800
Subject: [PATCH 0/3] tty: serial: Add mediatek MT8127 and MT8135 UART support 
Message-ID: <1413983529-21887-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch base on 3.18-rc1, which include mediatek MT65XX SOC
UART driver developed by Matthias Brugger, and
Joe.C's Mediatek MT8127 & MT8135 basic SOC support patch[1].

This patch fix one 8250_mtk.c bug that divisor maybe zero, and add device tree support.
Test ok on MT8127 and MT8135 tablet platform.

Eddie Huang (3):
  tty: serial: Fix mediatek UART driver setting baudrate issue
  ARM: mediatek: add UART dts for mt8127 and mt8135
  DTS: serial: Add bindings document for the Mediatek UARTs

 .../devicetree/bindings/serial/mtk-uart.txt        |  2 ++
 arch/arm/boot/dts/mt8127.dtsi                      | 34 ++++++++++++++++++++
 arch/arm/boot/dts/mt8135.dtsi                      | 36 ++++++++++++++++++++++
 drivers/tty/serial/8250/8250_mtk.c                 |  4 +--
 4 files changed, 74 insertions(+), 2 deletions(-)
