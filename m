From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 16 Nov 2014 01:04:01 +0100
Subject: [PATCHv1 0/3] arm: mvebu: add Synology DS213j and DS414 .dts files
Message-ID: <cover.1416095841.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds .dts files for Synology DS213j (armada 370 2-bay NAS) and
DS414 (armada XP 4-bay NAS) devices. It is based on comments received on
a v0 submission of DS213j .dts file [1].

Andrew, in this v1, the two .dts files are still separate w/o any common
.dtsi. I took a quick look it seems there are small differences between
the two which make me wonder if its worth the trouble:

 - DS414 fans are not handled by the SoC
 - various pinctrl variations
 - a tiny difference in SPI flash partitioning
 - phy-mode for ethernet interfaces
 - different comments associated w/ same nodes (e.g. uart1)
 - etc

Could you take a quick look and tell me if you think it's worth it? I'll
follow what you'll decide.

Cheers,

a+

[1]: http://thread.gmane.org/gmane.linux.drivers.devicetree/95401

Changes since v0:

 - Added a comment at the beginning of DS213j and DS414j .dts file regarding
   the need for a recent Marvell bootloader. Arnd suggested to do a specific
   .dtb file for new and old bootloaders but I think if we follow this path
   for DS414 and DS213j, we will probably have to do it for all Armada-based
   synology NAS and possibly for other Armada 370/XP based devices. Opting
   for recent bootloaders config and having a comment is easier. It is likely
   that a user already has a recent bootloader. Otherwise, upgrade is a one
   click process anyway. If a user thinks it is easier to have two different
   .dts files in the kernel, she will still be able to push a patch. 
 - Added a comment in the .dts file about the bootloader screwing the kernel
   if the environment is saved.
 - Kept GPL licence for .dts file
 - Fixed bad naming of node and alias (_ vs -)
 - Added micron vendor prefix for n25q064 flash
 - Disabled SoC RTC; a Seiko S-35390A is used as main RTC
 - Added comments about the purpose of each serial port
 - Added stdout-path = &uart0; to help barebox. A specific patch is included
   in the series to provide labels for uart serial nodes
 - Added patch for DS414 .dts file
 

Arnaud Ebalard (3):
  arm: mvebu: add uartX labels for Armada SoC serial nodes
  arm: mvebu: add .dts file for Synology DS213j
  arm: mvebu: add .dts file for Synology DS414

 arch/arm/boot/dts/Makefile                       |   6 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts | 351 +++++++++++++++++++++++
 arch/arm/boot/dts/armada-370-xp.dtsi             |   5 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts   | 343 ++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp.dtsi                 |   5 +-
 5 files changed, 704 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-370-synology-ds213j.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-synology-ds414.dts

-- 
2.1.1
