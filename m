From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 Apr 2016 09:49:04 +0200
Subject: [PATCH v4 0/5] Add XOR engine support to Armada 3700 SoC (ARM64)
Message-ID: <1461916149-30900-1-git-send-email-gregory.clement@free-electrons.com>
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

In this fourth series I took into account the remarks from Vinoud, I
also updated the dts patch that I will apply on my tree.

Thanks,

Gregory

Changelog:
v3 -> v4:
- Fix more typo in commit log of patch 3
- Add the warning fixed by patch 1
- Rebased the dt patch onto mvebu/dt64

v2 -> v3:
 - Add COMPILE_TEST dependency

v1 ->v2:
 - Fix typo in commit log of patch 3
 - Reformatting to 1 compatible string per line in
   Documentation/devicetree/bindings/dma/mv-xor.txt
 - Added Acked-by from Rob in patch 3


Gregory CLEMENT (4):
  dmaengine: mv_xor: make the code 64 bits compliant
  dmaengine: mv_xor: use SoC type instead of directly the operation mode
  dmaengine: mv_xor: Allow selecting mv_xor for mvebu only compatible
    SoC
  arm64: dts: marvell: add XOR node for Armada 3700 SoC

Marcin Wojtas (1):
  dmaengine: mv_xor: add support for Armada 3700 SoC

 Documentation/devicetree/bindings/dma/mv-xor.txt |  5 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi     | 13 ++++
 drivers/dma/Kconfig                              |  2 +-
 drivers/dma/mv_xor.c                             | 98 +++++++++++++++++++-----
 drivers/dma/mv_xor.h                             |  1 +
 5 files changed, 97 insertions(+), 22 deletions(-)

-- 
2.5.0
