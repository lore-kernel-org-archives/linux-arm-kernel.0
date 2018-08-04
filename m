From: manish.narani@xilinx.com (Manish Narani)
Date: Sat, 4 Aug 2018 14:55:31 +0530
Subject: [PATCH v4 0/4] EDAC: Enhancements to Synopsys EDAC driver
Message-ID: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enhances the current EDAC driver to support different
platforms.This series adds support for ZynqMP DDRC controller in synopsys
EDAC driver. This series also adds Device tree properties and relevant
binding documentation.

Changes in v2:
	- Moved checking of DDR_ECC_INTR_SUPPORT from (1/4) to (3/4) as it is
	  a feature of ZynqMP DDRC
	- The Binding Documentation in (2/4) is modified as per the review
	  comments

Changes in v3:
	- The commit message in (2/4) is modified (Synopsys EDAC Driver -->
	  ZynqMP DDRC)

Changes in v4:
	- Updated the commit message in (1/4)
	- Renamed function pointer names removing 'synps_' in (1/4)
	- Shortened unnecessary long lines as per the review comment on (1/4)

Manish Narani (4):
  edac: synps: Add platform specific structures for ddrc controller
  dt: bindings: Document ZynqMP DDRC in Synopsys documentation
  edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
  arm64: zynqmp: Add DDRC node

 .../bindings/memory-controllers/synopsys.txt       |  27 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   7 +
 drivers/edac/Kconfig                               |   2 +-
 drivers/edac/synopsys_edac.c                       | 945 ++++++++++++++++++++-
 4 files changed, 941 insertions(+), 40 deletions(-)

-- 
2.1.1
