From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Mar 2016 19:35:15 +0200
Subject: [PATCH 0/5] Add XOR engine support to Armada 3700 SoC (ARM64)
Message-ID: <1459359320-12638-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds the support of the Marvell XOR engine to the Armada
3700 SoC. As this SoC is an ARM64 one, then the code has been fixed to
support the 64 bits platform.

The initialization for the Armada 3700 is different from the other
SoCs, so in order to support it, a new way of handling the different
family have been added.

Once the dmaengine part will be approved, I will apply the dts part
in the mvebu/dt64 tree.

Thanks,

Gregory

Gregory CLEMENT (3):
  dmaengine: mv_xor: make the code 64 bits compliant
  dmaengine: mv_xor: use SoC type instead of directly the operation mode
  dmaengine: mv_xor: Allow selecting mv_xor for mvebu only compatible
    SoC

Marcin Wojtas (2):
  dmaengine: mv_xor: add support for Armada 3700 SoC
  arm64: dts: marvell: add XOR node for Armada 3700 SoC

 Documentation/devicetree/bindings/dma/mv-xor.txt |  3 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi     | 13 ++++
 drivers/dma/Kconfig                              |  2 +-
 drivers/dma/mv_xor.c                             | 98 +++++++++++++++++++-----
 drivers/dma/mv_xor.h                             |  1 +
 5 files changed, 95 insertions(+), 22 deletions(-)

-- 
2.5.0
