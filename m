From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 10 Oct 2015 00:10:05 +0200
Subject: [PATCH 0/2] arm: mvebu: disable unused rtc + cosmetic patch for
 ReadyNAS devices
Message-ID: <cover.1444428035.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are two simple patches for Armada-based ReadyNAS devices.

The first one disables Armada 370/XP rtc in the .dts files of ReadyNAS
102, 104 and 2120 devices. Those use an Intersil ISL12057 I2C RTC chip
and do not use the internal Armada RTC. Because it is enabled in
included armada-370-xp.dtsi, it just pollutes logs during boot.

While writing the patches, I noticed RN2120 .dts file has nodes that
are badly ordered under internal-regs. This second patch fixes
that. Note that it depends on first patch. 

Arnaud Ebalard (2):
  arm: mvebu: disable unused Armada RTC on ReadyNAS 102, 104 and 2120
  arm: mvebu: reorder internal-regs nodes by address in RN2120 .dts file

 arch/arm/boot/dts/armada-370-netgear-rn102.dts |  6 ++
 arch/arm/boot/dts/armada-370-netgear-rn104.dts |  6 ++
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 86 ++++++++++++++------------
 3 files changed, 58 insertions(+), 40 deletions(-)

-- 
2.5.3
