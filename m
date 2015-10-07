From: carlo@caione.org (Carlo Caione)
Date: Wed,  7 Oct 2015 22:31:01 +0200
Subject: [PATCH v2 0/4] Add support for Amlogic Meson8b and couple of boards
Message-ID: <1444249865-6897-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

A patchset sitting in my personal repo since forever. It adds the basic support
for Amlogic Meson8B SoCs and two common boards: Hardkernel Odroid-C1 and Tronfy
MXQ.

Changelog:
** v2:
 - Specified which board compatibles apply to which SOC
 - Added commit message specifying who is Tronfy

Carlo Caione (4):
  of: documentation: Add vendor prefix for Tronfy
  of: documentation: add bindings documentation for Meson8b
  ARM: meson: Add DTS for Odroid-C1 and Tronfy MXQ boards
  ARM: meson: Enable Meson8b SoCs

 Documentation/devicetree/bindings/arm/amlogic.txt  |  10 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/meson8b-mxq.dts                  |  67 ++++++++
 arch/arm/boot/dts/meson8b-odroidc1.dts             |  67 ++++++++
 arch/arm/boot/dts/meson8b.dtsi                     | 186 +++++++++++++++++++++
 arch/arm/mach-meson/Kconfig                        |   5 +
 arch/arm/mach-meson/meson.c                        |   1 +
 8 files changed, 338 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/meson8b-mxq.dts
 create mode 100644 arch/arm/boot/dts/meson8b-odroidc1.dts
 create mode 100644 arch/arm/boot/dts/meson8b.dtsi

-- 
1.9.1
