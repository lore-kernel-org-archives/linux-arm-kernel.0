From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Mon, 10 Sep 2018 20:43:52 +0530
Subject: [PATCH 0/4] Add 96Boards Rock960 CE board support
Message-ID: <20180910151356.25946-1-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds 96Boards Rock960 CE board support. Rock960 CE
(Consumer Edition) board is one of the member of 96Boards Consumer
Edition and AI platform and is manufactured by Vamrs Limited. Most of
the board configuration is shared with the Ficus board manufactured by
vamrs, which is an Enterprise 96Board.

For the sake of avoiding code duplication, a common rock960.dtsi file
with common DT nodes for both boards and separate board specific DTS
files has been added.

To be specific, below are some of the key differences between both
boards:

1. Different host enable GPIO for USB
2. Different power and reset GPIO for PCI-E
3. No Ethernet port on Rock960

While adding the board support, SD card Chip detection support is also
added to the common dtsi file, shared by both boards.

This series has been tested on Rock960 CE v1.2 board and expecting the
Ficus board maintainer to test the relevant Ficus part.

Thanks,
Mani

Manivannan Sadhasivam (4):
  arm64: dts: rockchip: Split out common nodes for Rock960 based boards
  dt-bindings: arm: rockchip: Add binding for Rock960 board
  arm64: boot: dts: rockchip: Add support for Rock960 board
  arm64: dts: rockchip: Enable SD card detection for Rock960 boards

 .../devicetree/bindings/arm/rockchip.txt      |   4 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 429 +----------------
 .../boot/dts/rockchip/rk3399-rock960.dts      | 139 ++++++
 .../boot/dts/rockchip/rk3399-rock960.dtsi     | 440 ++++++++++++++++++
 5 files changed, 585 insertions(+), 428 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi

-- 
2.17.1
