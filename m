From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Sat, 24 Sep 2016 17:14:20 +0800
Subject: [PATCH 0/5] arm64: dts: hisilicon: Hip06 fix and support Hip07 D05
 board
Message-ID: <1474708465-38958-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1) DTs
- Fix Hip06 ehci/ohci interrupt pin number.
- Add initial support for Hip07 D05 board.

2) PL011
- The sbsa uart is used on Hip07 SoC, the interrupt is connected to mbigen,
  but the uart probe(arch_init) is earlier than mbigen(module_init), so
  don't complain on -EPROBE_DEFER when no irq.
- Add earlycon support for SBSA UART.

Kefeng Wang (5):
  arm64: dts: hip06: Correct hardware pin number of usb node
  Documentation: arm64: Add Hisilicon Hip07 D05 dts binding
  arm64: dts: hisilicon: Add initial dts for Hip07 D05 board
  tty: amba-pl011: Don't complain on -EPROBE_DEFER when no irq
  tty: amba-pl011: Add earlycon support for SBSA UART

 .../bindings/arm/hisilicon/hisilicon.txt           |    4 +
 arch/arm64/boot/dts/hisilicon/Makefile             |    1 +
 arch/arm64/boot/dts/hisilicon/hip06.dtsi           |    4 +-
 arch/arm64/boot/dts/hisilicon/hip07-d05.dts        |   66 ++
 arch/arm64/boot/dts/hisilicon/hip07.dtsi           | 1059 ++++++++++++++++++++
 drivers/tty/serial/amba-pl011.c                    |    4 +-
 6 files changed, 1135 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip07-d05.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip07.dtsi

-- 
1.7.12.4
