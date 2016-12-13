From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 13 Dec 2016 16:59:44 +0530
Subject: [PATCH v2 0/3] ARM: dts: dra7-evm: pinmuxing updates
Message-ID: <cover.1481628266.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series drops most of the pinmuxing from dra7-evm
to satisfy erratum i869 and adds missing eMMC and SD card pinmuxing.

The patches apply to latest linux-next. Tested on DRA74x EVM Rev H
using U-Boot 2016.11. Boot tested using NFS and basic testing carried
out on SD card, eMMC, Audio capture and playback.

NAND on DRA72 EVM is already unusable due to a similar patch. A patch
included here disables the GPMC node.

v1 -> v2:
- Add a patch to disable GPMC node on DRA72x EVM
- Disable GPMC node on DRA74x EVM

Kishon Vijay Abraham I (1):
  ARM: dts: dra7-evm: add pinmux configuration for mmc1/2

Sekhar Nori (2):
  ARM: dts: dra7-evm: Remove pinmux configurations for erratum i869
  ARM: dts: dra72-evm: drop NAND support

 arch/arm/boot/dts/dra7-evm.dts          | 282 ++++----------------------------
 arch/arm/boot/dts/dra72-evm-common.dtsi |   7 +-
 2 files changed, 35 insertions(+), 254 deletions(-)

-- 
2.9.0
