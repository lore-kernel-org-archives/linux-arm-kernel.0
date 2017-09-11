From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Mon, 11 Sep 2017 23:10:26 +0800
Subject: [PATCH v5 0/3] PCI: rockchip: Move PCIE_WAKE handling into rockchip
 pcie driver
Message-ID: <20170911151029.25185-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Currently we are handling pcie wake in mrvl wifi driver. But Brian
suggests to move it into rockchip pcie driver.

Tested on my chromebook bob(with cros 4.4 kernel and mrvl wifi).


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
 drivers/pci/host/pcie-rockchip.c              | 19 +++++++++++++++++--
 3 files changed, 28 insertions(+), 8 deletions(-)

-- 
2.11.0
