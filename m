From: robh@kernel.org (Rob Herring)
Date: Wed,  5 Apr 2017 13:30:01 -0500
Subject: [PATCH 0/4] TI Bluetooth serdev support
Message-ID: <20170405183005.20570-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds serdev support to the HCI LL protocol used on TI BT
modules and enables support on HiKey board with with the WL1835 module.
With this the custom TI UIM daemon and btattach are no longer needed.

The series is available on this git branch[1]. Patch 2 is just clean-up
and can be applied independently. Patch 3 is dependent on the series
"Nokia H4+ support". I'd suggest both series are merged thru the BT tree.

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git ti-bluetooth

Rob Herring (4):
  dt-bindings: net: Add TI WiLink shared transport binding
  bluetooth: hci_uart: remove unused hci_uart_init_tty
  bluetooth: hci_uart: add LL protocol serdev driver support
  arm64: dts: hikey: add WL1835 Bluetooth device node

 .../devicetree/bindings/net/ti,wilink-st.txt       |  35 +++
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |   5 +
 drivers/bluetooth/hci_ldisc.c                      |  19 --
 drivers/bluetooth/hci_ll.c                         | 261 ++++++++++++++++++++-
 drivers/bluetooth/hci_uart.h                       |   1 -
 5 files changed, 300 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ti,wilink-st.txt

--
2.10.1
