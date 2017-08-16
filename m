From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed, 16 Aug 2017 15:52:21 +0800
Subject: [RFC PATCH 0/3] PCI: rockchip: Move PCIE_WAKE handling into rockchip
 pcie driver
Message-ID: <20170816075224.31734-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Currently we are handling pcie wake in mrvl wifi driver. But Brian
suggests to move it into rockchip pcie driver.

Tested on my chromebook bob(with cros 4.4 kernel and mrvl wifi).



Jeffy Chen (3):
  PCI: rockchip: Add support for pcie wake irq
  dt-bindings: PCI: rockchip: Add support for pcie wake irq
  arm64: dts: rockchip: Handle pcie wake in pcie driver for Gru

 .../devicetree/bindings/pci/rockchip-pcie.txt      | 11 ++--
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       | 17 ++++---
 drivers/pci/host/pcie-rockchip.c                   | 58 ++++++++++++++++++++++
 3 files changed, 76 insertions(+), 10 deletions(-)

-- 
2.11.0
