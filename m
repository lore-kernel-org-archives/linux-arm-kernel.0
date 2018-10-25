From: manish.narani@xilinx.com (Manish Narani)
Date: Thu, 25 Oct 2018 11:36:55 +0530
Subject: [PATCH v10 0/6] EDAC: Enhancements to Synopsys EDAC driver
Message-ID: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enhances the current EDAC driver to support different
platforms. This series adds support for ZynqMP DDRC controller in synopsys
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

Changes in v5:
	- Updated the commit message in (2/4) and (4/4).
	- Removed the unnecessary check for match data in probe() in (1/4)
	- Some Indentation changes for better readability in (1/4) and (3/4)
	- Removed repeated code in (3/4)
	- Used 'zynq' and 'zynqmp' instead of 'synps_enh_edac' in function names

Changes in v6:
	- Splitted the patches according to functionalities
	- Addressed code style comments from v5 review
	- Moved the Error Injection to CONFIG_EDAC_DEBUG mode

Changes in v7:
	- Included DTS patch (6/7) which was missed in v6 patch set

Changes in v8:
	- patch (1/7) from v7 is split in to 3 different logically different patches
		1. functional changes like code cleanup
		2. functions renaming
		3. comments cleanup
	- Added a separate patch (4) for making always successful functions as void
	- Corrected 'Too many parentheses' review comment in patch (5)
	- Corrected comments as per the v7 review feedback
	- Made dedicated functions for IRQ setup, IRQ enable and IRQ disable in patch (8)
	- Addressed review comments in patch (10)

Changes in v9:
	- Added check for return value of of_device_get_match_data() function
	  in (1/6).
	- From v8 the first 5 patches are removed in this series as they are
	  applied on:
		https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/?h=edac-for-4.20-synps
	- Updated Kconfig to check for ARCH_ZYNQMP instead of ARM64

Change in v10:
	- Moved the checking for ce_cnt and ue_cnt before the readl() call
	- Aligned arguments on the opening brace in setup_irq()

Manish Narani (6):
  edac: synopsys: Add error handling for NULL in probe()
  dt: bindings: Document ZynqMP DDRC in Synopsys documentation
  edac: synopsys: Add macro defines for ZynqMP DDRC
  edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
  arm64: zynqmp: Add DDRC node
  edac: synopsys: Add Error Injection support for ZynqMP DDRC

 .../bindings/memory-controllers/synopsys.txt       |  27 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   7 +
 drivers/edac/Kconfig                               |   2 +-
 drivers/edac/synopsys_edac.c                       | 911 ++++++++++++++++++++-
 4 files changed, 918 insertions(+), 29 deletions(-)

-- 
2.1.1
