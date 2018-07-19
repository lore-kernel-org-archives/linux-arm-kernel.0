From: manish.narani@xilinx.com (Manish Narani)
Date: Thu, 19 Jul 2018 15:35:43 +0530
Subject: [PATCH 0/4] EDAC: Enhancements to Synopsys EDAC driver
Message-ID: <1531994747-15196-1-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enhances the current EDAC driver to support different
platforms.This series adds support for ZynqMP DDRC controller in synopsys
EDAC driver. This series also adds Device tree properties and relevant
binding documentation.

Manish Narani (4):
  edac: synps: Add platform specific structures for ddrc controller
  dt: bindings: Document ZynqMP DDRC in Synopsys documentation
  edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
  arm64: zynqmp: Add DDRC node

 .../bindings/memory-controllers/synopsys.txt       |  25 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   7 +
 drivers/edac/Kconfig                               |   2 +-
 drivers/edac/synopsys_edac.c                       | 916 ++++++++++++++++++++-
 4 files changed, 918 insertions(+), 32 deletions(-)

-- 
2.1.1
