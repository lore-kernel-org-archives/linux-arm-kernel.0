From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Sat, 14 Oct 2017 03:50:55 +0800
Subject: [PATCH v6 0/3] PCI: rockchip: Move PCIE_WAKE handling into rockchip
 pcie driver
Message-ID: <20171013195059.23865-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Currently we are handling pcie wake in mrvl wifi driver. But Brian
suggests to move it into rockchip pcie driver.

Tested on my chromebook bob(with cros 4.4 kernel and mrvl wifi).


Changes in v6:
Fix device_init_wake error handling, and add some comments.

Changes in v5:
Rebase
Move to pci.txt
Use "wakeup" instead of "wake"

Changes in v3:
Fix error handling

Changes in v2:
Use dev_pm_set_dedicated_wake_irq
        -- Suggested by Brian Norris <briannorris@chromium.com>

Jeffy Chen (3):
  PCI: rockchip: Add support for pcie wake irq
  dt-bindings: PCI: Add definition of pcie wake irq
  arm64: dts: rockchip: Handle pcie wake in pcie driver for Gru

 Documentation/devicetree/bindings/pci/pci.txt |  2 ++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 15 +++++++++------
 drivers/pci/host/pcie-rockchip.c              | 27 +++++++++++++++++++++------
 3 files changed, 32 insertions(+), 12 deletions(-)

-- 
2.11.0
