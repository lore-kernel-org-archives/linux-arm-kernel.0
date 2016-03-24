From: raveendra.padasalagi@broadcom.com (Raveendra Padasalagi)
Date: Thu, 24 Mar 2016 11:17:12 +0530
Subject: [PATCH v5 0/3] Syscon support for iProc touchscreen driver
Message-ID: <1458798435-20222-1-git-send-email-raveendra.padasalagi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based on v4.5-rc3 tag and its tested on
Broadcom Cygnus SoC.

The patches can be fetched from iproc-tsc-v5 branch of
https://github.com/Broadcom/arm64-linux.git

Changes since v4:
 - Fixed odd_ptr_err.cocci script warning

Changes since v3:
 - Renamed touchscreen node "tsc" to "touchscreen" in dt binding document
 - Added support for syscon only based register access in touch screen
   driver and removed "regs" based register access. Updated dt binding
   document to reflect the changes.
 - Removed "brcm,iproc-touchscreen-syscon" compatible string support in
   dt binding document and touchscreen driver implementation.

Changes since v2:
 - Omitted '0x' in "tsc node" definition in dt documentation file
 - Omitted '0x' in "ts_adc_syscon" definition in dt documentation file
 - Added "brcm,iproc-ts-adc-syscon" compatible string in "ts_adc_syscon"
   node. Updated dt documentation file to reflect this change.

Changes since v1:
 - Enhanced touchscreen driver to handle syscon based register access if
   "brcm,iproc-touchscreen-syscon" compatible string is provided in dt
 - Normal register access is handled through readl and writel API's if
   "brcm,iproc-touchscreen" compatible string is provided.
 - Updated touchscreen dt node document to reflect the new changes.
 - Updated change logs in each patchset to reflect the new changes

Raveendra Padasalagi (3):
  input: cygnus-update touchscreen dt node document
  input: syscon support in bcm_iproc_tsc driver
  ARM: dts: use syscon in cygnus touchscreen dt node

 .../input/touchscreen/brcm,iproc-touchscreen.txt   | 21 ++++--
 arch/arm/boot/dts/bcm-cygnus.dtsi                  | 11 ++-
 drivers/input/touchscreen/bcm_iproc_tsc.c          | 79 ++++++++++++----------
 3 files changed, 69 insertions(+), 42 deletions(-)

-- 
1.9.1
