From: raveendra.padasalagi@broadcom.com (Raveendra Padasalagi)
Date: Mon, 22 Feb 2016 13:19:36 +0530
Subject: [PATCH v3 0/3] Syscon support for iProc touchscreen driver
Message-ID: <1456127379-25866-1-git-send-email-raveendra.padasalagi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based on v4.5-rc3 tag and its tested on
Broadcom Cygnus SoC.

The patches can be fetched from iproc-tsc-v3 branch of
https://github.com/Broadcom/arm64-linux.git

Changes since v2:
 - Omitted '0x' in "tsc node" definition in dt documentation file
 - Omitted '0x' in "ts_adc_syscon" definition in dt documentation file
 - Added "brcm,iproc-ts-adc-syscon" compatible string in "ts_adc_syscon"
   node. Updated dt documentation file to reflect this change.

Raveendra Padasalagi (3):
  input: cygnus-update touchscreen dt node document
  input: syscon support in bcm_iproc_tsc driver
  ARM: dts: use syscon in cygnus touchscreen dt node

 .../input/touchscreen/brcm,iproc-touchscreen.txt   |  59 +++++++-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  11 +-
 drivers/input/touchscreen/bcm_iproc_tsc.c          | 152 +++++++++++++++------
 3 files changed, 173 insertions(+), 49 deletions(-)

-- 
1.9.1
