From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 17 Jun 2015 14:12:17 +0200
Subject: [PATCH RESEND 0/4] dmaengine: mv_xor improvements
Message-ID: <1434543141-3242-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

(Same patches as previous iteration, only this time the relevant
mailing list are in Cc. Sorry for the noise.)

The following four patches implement various improvements in the
support of XOR on Marvell EBU platforms:

 - It adds support for suspend/resume to mv_xor.

 - It removes the need for the dmacap,* Device Tree properties, which
   are quite useful.

 - It updates the Device Tree according to the removal of the dmacap,*
   removal, and make Armada 38x and Armada 39x use the new
   capabilities of the XOR hardware using the armada-380-xor
   compatible string.

The patches are on top of Vinod Koul's next branch, since he already
has a number of mv_xor changes queued up.

Thanks,

Thomas

Thomas Petazzoni (4):
  dmaengine: mv_xor: add suspend/resume support
  dmaengine: mv_xor: remove support for dmacap,* DT properties
  ARM: mvebu: remove unneeded dmacap,* properties in Device Trees
  ARM: mvebu: use armada-380-xor on Armada 38x and 39x

 Documentation/devicetree/bindings/dma/mv-xor.txt | 10 ++---
 arch/arm/boot/dts/armada-370.dtsi                | 10 -----
 arch/arm/boot/dts/armada-375.dtsi                | 10 -----
 arch/arm/boot/dts/armada-38x.dtsi                | 14 +-----
 arch/arm/boot/dts/armada-39x.dtsi                | 14 +-----
 arch/arm/boot/dts/armada-xp.dtsi                 | 10 -----
 arch/arm/boot/dts/dove.dtsi                      |  8 ----
 drivers/dma/mv_xor.c                             | 56 +++++++++++++++++++++---
 drivers/dma/mv_xor.h                             |  1 +
 9 files changed, 59 insertions(+), 74 deletions(-)

-- 
2.1.0
