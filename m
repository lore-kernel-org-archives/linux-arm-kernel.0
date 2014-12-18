From: eddie.huang@mediatek.com (Eddie Huang)
Date: Thu, 18 Dec 2014 16:33:19 +0800
Subject: [PATCH 0/2] tty: serial: Add earlycon support to MT8173 SoC
Message-ID: <1418891601-53769-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add earlycon support to Mediatek MT8173 SoC. Although 8250 driver
already has earlycon support, but Mediatek UART has highspeed register that
not in 8250_early.c, so I port earlycon in 8250_mtk.c, and add stdout device
tree support.

This patchset is based on 3.18, and my basic support for Mediatek MT8173 Soc [1].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/311238.html

Eddie Huang (2):
  tty: serial: 8250_mtk: Add earlycon
  arm64: dts: Add mediatek MT8173 earlycon support

 arch/arm64/boot/dts/mt8173-evb.dts |  4 +++-
 drivers/tty/serial/8250/8250_mtk.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

--
1.8.1.1.dirty
