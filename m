From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 30 Aug 2016 22:52:47 +0200
Subject: [PATCH 0/3] remove skeleton.dtsi from armv7-m.dtsi
Message-ID: <20160830205250.15616-1-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

This patch set removes skeleton.dtsi from the common ARM Cortex-M dtsi.
This will allow us to remove skeleton.dtsi on a per platform basis and
get rid of the unit address warning on the memory nodes without getting
duplicate memory nodes.

See 3ebee5a2e141 ("arm64: dts: kill skeleton.dtsi") for additional
reasons not to use the skeleton.dtsi.

I plan to take atleast the first two patches through the lpc18xx tree.
Please ack if you are okey with the change to your platform dtsi file.


Joachim Eastwood (3):
  ARM: dts: armv7-m: remove skeleton.dtsi include
  ARM: dts: lpc18xx: remove skeleton.dtsi include and fix unit address warnings
  ARM: dts: efm32: remove skeleton.dtsi include and fix unit address warnings

 arch/arm/boot/dts/armv7-m.dtsi              | 2 --
 arch/arm/boot/dts/efm32gg-dk3750.dts        | 5 +++--
 arch/arm/boot/dts/efm32gg.dtsi              | 4 ++++
 arch/arm/boot/dts/lpc18xx.dtsi              | 3 +++
 arch/arm/boot/dts/lpc4337-ciaa.dts          | 2 +-
 arch/arm/boot/dts/lpc4350-hitex-eval.dts    | 2 +-
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 2 +-
 arch/arm/boot/dts/mps2.dtsi                 | 1 +
 arch/arm/boot/dts/stm32f429.dtsi            | 1 +
 arch/arm/boot/dts/vf610m4.dtsi              | 1 +
 10 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.9.3
