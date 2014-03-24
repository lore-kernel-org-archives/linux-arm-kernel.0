From: mohun106@gmail.com (mohun106 at gmail.com)
Date: Mon, 24 Mar 2014 14:39:36 +0530
Subject: [PATCH v2 0/3] Add support for Cavium Thunder ARMv8 platform
Message-ID: <1395652179-9216-1-git-send-email-mohun106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

This patch series adds preliminary support for Cavium's Thunder SoC
which is based on ARMv8 core.

This patchset depends on following. They need to be applied before
working.

1) Boot time configuration of IPA
http://www.spinics.net/lists/arm-kernel/msg313723.html

2) GICv3 driver from Marc Zyngier
http://www.spinics.net/lists/kvm-arm/msg08544.html

3) GICv3 devicetree bindings from Marc Zyngier
http://www.spinics.net/lists/kvm-arm/msg08545.html

Changes from v1:
---------------
- Added documentation for the devicetree bindings used.
- Changed the Thunder device tree as per documentation.

Radha Mohan Chintakuntla (3):
  arm64: Add Kconfig option for Cavium Thunder SoC Family
  arm64: dts: Add initial dts for Cavium Thunder SoC
  Documentation: add devicetree bindings for Cavium Thunder SoC

 .../devicetree/bindings/arm/cavium-thunder.txt     |    9 +
 Documentation/devicetree/bindings/arm/cpus.txt     |    1 +
 arch/arm64/Kconfig                                 |    5 +
 arch/arm64/boot/dts/Makefile                       |    1 +
 arch/arm64/boot/dts/thunder.dts                    |  160 ++++++++++++++++++++
 5 files changed, 176 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder.txt
 create mode 100644 arch/arm64/boot/dts/thunder.dts
