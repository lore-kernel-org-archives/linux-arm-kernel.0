From: marcel@holtmann.org (Marcel Holtmann)
Date: Thu, 13 Apr 2017 19:24:30 +0200
Subject: [PATCH v3 0/4] TI Bluetooth serdev support
In-Reply-To: <20170413150353.7389-1-robh@kernel.org>
References: <20170413150353.7389-1-robh@kernel.org>
Message-ID: <A73F0F81-63B4-4555-9865-F35469902338@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> This series adds serdev support to the HCI LL protocol used on TI BT
> modules and enables support on HiKey board with with the WL1835 module.
> With this the custom TI UIM daemon and btattach are no longer needed.
> 
> The series is available on this git branch[1]. This version is rebased on 
> bluetooth-next tree containing its dependencies.
> 
> Rob
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git ti-bluetooth
> 
> Rob Herring (4):
>  dt-bindings: net: Add TI WiLink shared transport binding
>  bluetooth: hci_uart: remove unused hci_uart_init_tty
>  bluetooth: hci_uart: add LL protocol serdev driver support
>  arm64: dts: hikey: add WL1835 Bluetooth device node
> 
> .../devicetree/bindings/net/ti,wilink-st.txt       |  35 +++
> arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |   5 +
> drivers/bluetooth/hci_ldisc.c                      |  19 --
> drivers/bluetooth/hci_ll.c                         | 262 ++++++++++++++++++++-
> drivers/bluetooth/hci_uart.h                       |   1 -
> 5 files changed, 301 insertions(+), 21 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/net/ti,wilink-st.txt

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel
