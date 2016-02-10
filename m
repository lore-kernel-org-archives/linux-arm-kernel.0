From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 10 Feb 2016 14:27:16 +0000
Subject: [GIT PULL] VExpress/Juno: DT updates for v4.6
Message-ID: <56BB48C4.4040604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Please pull DT updates for VExpress/Juno platforms

--
Regards,
Sudeep

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git 
tags/vexpress-for-v4.6/dt-updates

for you to fetch changes up to 9fd9288ed0899f9e318a97d73e777d6d3357265e:

   arm64: dts: Add HDLCD support on Juno platforms (2016-02-10 10:58:33 
  +0000)

----------------------------------------------------------------
Few updates for ARM VExpress/Juno platforms

1. GICv3 support on Foundation models

2. Support for Juno R2 board

3. Support for ARM HDLCD on all Juno platforms

----------------------------------------------------------------
Andre Przywara (4):
       arm64: dts: prepare foundation-v8.dts to cope with GICv3
       arm64: dts: Foundation model: increase GICC region to allow EOImode=1
       arm64: dts: split Foundation model dts to put the GIC separately
       arm64: dts: add .dts for GICv3 Foundation model

Liviu Dudau (2):
       Documentation: drm: Add DT bindings for ARM HDLCD
       arm64: dts: Add HDLCD support on Juno platforms

Sudeep Holla (2):
       arm64: dts: move juno pcie-controller to base file
       arm64: dts: Add support for Juno r2 board

  Documentation/devicetree/bindings/arm/arm-boards   |   1 +
  .../devicetree/bindings/display/arm,hdlcd.txt      |  79 +++++++
  arch/arm64/boot/dts/arm/Makefile                   |   4 +-
  arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts    |  30 +++
  arch/arm64/boot/dts/arm/foundation-v8.dts          | 227 
+-------------------
  arch/arm64/boot/dts/arm/foundation-v8.dtsi         | 228 
+++++++++++++++++++++
  arch/arm64/boot/dts/arm/juno-base.dtsi             |  68 +++++-
  arch/arm64/boot/dts/arm/juno-r1.dts                |  25 +--
  arch/arm64/boot/dts/arm/juno-r2.dts                | 183 +++++++++++++++++
  9 files changed, 595 insertions(+), 250 deletions(-)
  create mode 100644 Documentation/devicetree/bindings/display/arm,hdlcd.txt
  create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts
  create mode 100644 arch/arm64/boot/dts/arm/foundation-v8.dtsi
  create mode 100644 arch/arm64/boot/dts/arm/juno-r2.dts
