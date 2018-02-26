From: michel.pollet@bp.renesas.com (Michel Pollet)
Date: Mon, 26 Feb 2018 12:18:18 +0000
Subject: [PATCH 0/2] arm: Support for Renesas RZ/N1D (R9A06G032)
Message-ID: <1519647518-15579-1-git-send-email-michel.pollet@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the plain basic support for booting a bare
kernel on the RZ/N1D-DB Board. It's been trimmed to the strict
minimum as a 'base', further patches that will add the
rest of the support, pinctrl, clock architecture and quite
a few others.

Michel Pollet (2):
  arm: add basic support for Renesas RZ/N1 boards
  arm: rzn1: Add basic support for RZN1D-DB Board

 Documentation/devicetree/bindings/arm/shmobile.txt |   5 +-
 arch/arm/boot/dts/rzn1.dtsi                        |  94 +++
 arch/arm/boot/dts/rzn1d400-db.dts                  |  25 +
 arch/arm/mach-shmobile/Kconfig                     |   5 +
 arch/arm/mach-shmobile/Makefile                    |   1 +
 arch/arm/mach-shmobile/setup-r9a06g032.c           |  60 ++
 .../dt-bindings/interrupt-controller/rzn1-irq.h    | 137 ++++
 include/dt-bindings/soc/renesas,rzn1-map.h         | 173 +++++
 include/soc/rzn1/sysctrl.h                         | 736 +++++++++++++++++++++
 9 files changed, 1235 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/rzn1.dtsi
 create mode 100644 arch/arm/boot/dts/rzn1d400-db.dts
 create mode 100644 arch/arm/mach-shmobile/setup-r9a06g032.c
 create mode 100644 include/dt-bindings/interrupt-controller/rzn1-irq.h
 create mode 100644 include/dt-bindings/soc/renesas,rzn1-map.h
 create mode 100644 include/soc/rzn1/sysctrl.h

-- 
2.7.4
