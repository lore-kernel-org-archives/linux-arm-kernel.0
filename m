From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu, 19 Oct 2017 19:10:04 +0800
Subject: [PATCH v7 0/3] PCI: rockchip: Move PCIE_WAKE handling into pci core
Message-ID: <20171019111007.25234-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Currently we are handling wake irq in mrvl wifi driver. Move it into
pci core.

Tested on my chromebook bob(with cros 4.4 kernel and mrvl wifi).


Changes in v7:
Move PCIE_WAKE handling into pci core.

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
  PCI: Add support for wake irq
  dt-bindings: PCI: Add definition of pcie wake irq
  arm64: dts: rockchip: Handle pcie wake in pcie driver for Gru

 Documentation/devicetree/bindings/pci/pci.txt |  2 ++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 15 +++++++-----
 drivers/pci/pci.c                             | 34 +++++++++++++++++++++++++--
 drivers/pci/probe.c                           | 32 +++++++++++++++++++++----
 drivers/pci/remove.c                          |  9 +++++++
 5 files changed, 80 insertions(+), 12 deletions(-)

-- 
2.11.0
