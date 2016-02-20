From: jchandra@broadcom.com (Jayachandran C)
Date: Sat, 20 Feb 2016 19:49:19 +0530
Subject: [PATCH v2 0/5] Support for Broadcom Vulcan ARM64 processor
Message-ID: <1455977964-8099-1-git-send-email-jchandra@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for Broadcom's Vulcan ARM64 processor.
The changes are to add the device tree files, documentation for the
device tree, cpu ID and the maintainers entry.

This is v2 of the patchset, changelog below:

v1->v2 :
 - dts: remove memreserve, use brcm,vulcan-soc for board
   (to address comments from Mark Rutland)
 - Fixup copyright (Broadcomp corp -> Broadcom)
   (suggested by Florian Fainelli)
 - Rename dts from brcm-vulcan* to vulcan*
   (suggested by Ray Jui)
 - Add maintainers entry
   (suggested by Florian Fainelli)
 - Updated the device tree doc and fixed a couple of commit
   comments

Jayachandran C (4):
  dt-bindings: Add documentation for Broadcom Vulcan
  arm64: defconfig: Add Broadcom Vulcan to defconfig
  arm64: cputype info for Broadcom Vulcan
  MAINTAINERS: Add entry for Broadcom Vulcan SoC

Zi Shen Lim (1):
  arm64: Broadcom Vulcan support

 .../bindings/arm/bcm/brcm,vulcan-soc.txt           |  10 ++
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 MAINTAINERS                                        |   7 +
 arch/arm64/Kconfig.platforms                       |   5 +
 arch/arm64/boot/dts/broadcom/Makefile              |   1 +
 arch/arm64/boot/dts/broadcom/vulcan-eval.dts       |  33 +++++
 arch/arm64/boot/dts/broadcom/vulcan.dtsi           | 144 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   1 +
 arch/arm64/include/asm/cputype.h                   |   3 +
 9 files changed, 205 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt
 create mode 100644 arch/arm64/boot/dts/broadcom/vulcan-eval.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/vulcan.dtsi

-- 
1.9.1
