From: beagleboard@davidjohnsummers.uk (David Summers)
Date: Sat, 22 Sep 2018 18:02:33 +0100
Subject: [PATCH 0/3] Device Tree for ASUS Tinker Board S [v3]
Message-ID: <20180922170236.8690-1-beagleboard@davidjohnsummers.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So third try on these patches, hope these work, git commands are difficult
So I hope these work.

The ASUS Tinker Board S : https://www.asus.com/uk/Single-Board-Computer/Tinker-Board-S/

Is a variant on the original ASUS Tinker Board, the main difference being that the "S" has eMMC.

This patchset sets up the device tree for the "S". It is based on the patches used with the debian distribution which ships with the device : https://github.com/TinkerBoard/debian_kernel/blob/develop/arch/arm/boot/dts/rk3288-miniarm.dts

So this is really just mainlining the support.

I've split the changed into three parts:

  .  This part - just creates a new dts file that is a copy of the tinker board, with just a name change
  .  Changes needed to add the eMMC
It is based on: https://github.com/TinkerBoard/debian_kernel/commit/dc7d4eb4140b4e5ff23aaf2864a56d5c8634f3d0

With the speed change from

https://github.com/TinkerBoard/debian_kernel/commit/4b52627037958bc95ed3f67ff96bbbadbb2bfe07

The patch is relatively straight forward. Only oddity that it seems to be on the sd card slot at &sdmmc; when booting from eMMC and there is no card in the sd slot - then the kernel keeps scanning the sd slot. So it looks like card detect isn't functioning correctly on &sdmmc. This probably wasn't noted on the original Tinker Board, as that had to have a sd card in order to boot. Alas the schematic for the tinker board doesn't show how the sd card is wired ...:

http://dlcdnet.asus.com/pub/ASUS/mb/Linux/Tinker_Board_2GB/Tinker_Board_Schematics.zip
  .  Changes needed to enable wifi
Its based on: https://github.com/TinkerBoard/debian_kernel/commit/6a3128ade33f758887048578ada61a4b7ab8e678

The changes here are more extensive, basic communication is via sdio0, but can also be seen that connections are set up to the RK808 e.g. the power management chip.

This is the first patch I've done for linux - so if I've got anything wrong, just let me know and I'll correct.

Also any comments you have.

Regards,

David Summers

David Summers (3):
  Add the tinker board S to the device tree - just an outline
  This patch add the eMMC to the ASUS tinker board S
  This patch adds wifi to asus tinker board S
  

 .../devicetree/bindings/arm/rockchip.txt      |   4 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/rk3288-tinker-s.dts         | 120 +++++
 arch/arm/boot/dts/rk3288-tinker.dts           | 498 +----------------
 arch/arm/boot/dts/rk3288-tinker.dtsi          | 504 ++++++++++++++++++
 5 files changed, 631 insertions(+), 496 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-tinker-s.dts
 create mode 100644 arch/arm/boot/dts/rk3288-tinker.dtsi

-- 
David Summers <beagleboard@davididjohnsummers.uk>
