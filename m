From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 13 Oct 2015 10:37:45 +0100
Subject: [PATCH 0/4] add support for GICv3 on the Foundation model
Message-ID: <1444729069-27922-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the freely available ARM Foundation model [1] supports emulating a
GICv3 interrupt controller (--gicv3).
To provide the kernel with the proper information, prepare the
existing model .dts to be split up and eventually create a new .dts
file which can be used to boot a kernel using the GICv3 in the model.

Patch 1/4 changes the common device tree to allow sharing most of the
definitions later, while patch 2/4 is a drive-by-fix to add support
for the recently enabled EOImode=1.
Patch 3/4 splits the existing DT up to have a common .dtsi file and a
stub foundation-v8.dts in preparation for the final patch 4/4, which
adds a new foundation-v8-gicv3.dts that has the required GICv3 node.

Together with the GICv3 support of the bootwrapper this allows to boot
Linux and make it use the GICv3 interrupt controller.

Cheers,
Andre.

[1]: http://www.arm.com/products/tools/models/fast-models/foundation-model.php

Andre Przywara (4):
  arm64: dts: prepare foundation-v8.dts to cope with GICv3
  arm64: dts: Foundation model: increate GICC region to allow EOImode=1
  arm64: dts: split Foundation model dts to put the GIC separately
  arm64: dts: add .dts for GICv3 Foundation model

 arch/arm64/boot/dts/arm/Makefile                   |   2 +-
 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts    |  30 +++
 arch/arm64/boot/dts/arm/foundation-v8.dts          | 227 +--------------------
 .../arm/{foundation-v8.dts => foundation-v8.dtsi}  |  98 ++++-----
 4 files changed, 78 insertions(+), 279 deletions(-)
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts
 copy arch/arm64/boot/dts/arm/{foundation-v8.dts => foundation-v8.dtsi} (73%)

-- 
2.5.1
