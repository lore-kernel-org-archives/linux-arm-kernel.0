From: raveendra.padasalagi@broadcom.com (Raveendra Padasalagi)
Date: Wed, 17 Feb 2016 15:13:43 +0530
Subject: [PATCH v2 0/3] Syscon support for iProc touchscreen driver
Message-ID: <1455702226-20599-1-git-send-email-raveendra.padasalagi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based on v4.5-rc3 tag and its tested on
Broadcom Cygnus SoC.

The patches can be fetched from iproc-tsc-v2 branch of
https://github.com/Broadcom/arm64-linux.git

Changes since v1:
 - Enhanced touchscreen driver to handle syscon based register access if
   "brcm,iproc-touchscreen-syscon" compatible string is provided in dt
 - Normal register access is handled through readl and writel API's if
   "brcm,iproc-touchscreen" compatible string is provided.
 - Updated touchscreen dt node document to reflect the new changes.
 - Updated change logs in each patchset to reflect the new changes.

Raveendra Padasalagi (3):
  input: cygnus-update touchscreen dt node document
  input: syscon support in bcm_iproc_tsc driver
  ARM: dts: use syscon in cygnus touchscreen dt node

 .../input/touchscreen/brcm,iproc-touchscreen.txt   |  57 +++++++-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  11 +-
 drivers/input/touchscreen/bcm_iproc_tsc.c          | 152 +++++++++++++++------
 3 files changed, 172 insertions(+), 48 deletions(-)

-- 
1.9.1
