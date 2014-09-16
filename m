From: kever.yang@rock-chips.com (Kever Yang)
Date: Tue, 16 Sep 2014 18:44:27 +0800
Subject: [PATCH v2 0/3] add basic rk3288 smp support
Message-ID: <1410864271-9277-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rk3288 is qual-core CPU Soc, we need to enable the smp.
This patchset works with either arch-timer use the phisical counter
in kernel or the firmware initialize the arch-timer virtual counter
offset and use virtual counter in kernel.

Changes in v2:
- add documentation
- use rk3288_boot_secondary instead ofsmp_boot_secondary
- discards the power domain operation
- handle the per cpu starup when actived by 'sev'
- adjust the alignment

Kever Yang (3):
  Documentation: dt-bindings: add dt binding info for rk3288-smp
  ARM: rockchip: add basic smp support for rk3288
  ARM: dts: add intmem node for rk3288 smp support

 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 arch/arm/boot/dts/rk3288.dtsi                  | 18 ++++++++
 arch/arm/mach-rockchip/core.h                  |  1 +
 arch/arm/mach-rockchip/headsmp.S               | 14 ++++++
 arch/arm/mach-rockchip/platsmp.c               | 63 +++++++++++++++++++++++---
 5 files changed, 91 insertions(+), 6 deletions(-)

-- 
1.9.1
