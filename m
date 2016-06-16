From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 16 Jun 2016 15:42:24 +0200
Subject: [PATCH 0/3] Misc fixes for Marvell EBU platforms
Message-ID: <1466084547-31343-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This small patch series carries a few fixes for Marvell EBU platforms:

 - The first one fixes HW I/O coherency deadlocks that can be easily
   reproduced with the CESA crypto engine.

 - The second one makes sure PCI I/O regions are mapped
   strongly-ordered. While this is technically a requirement for the
   HW I/O coherency to work reliably, PCI I/O regions are very rarely
   used and we have therefore never seen a problem caused by
   this. Therefore, I have not Cc'ed this patch to stable.

 - The third one fixes the MBus window attributes used to map the CESA
   SRAMs on Armada 385 Linksys platforms.

Thanks!

Thomas

Thomas Petazzoni (3):
  ARM: mvebu: fix HW I/O coherency related deadlocks
  ARM: mvebu: map PCI I/O regions strongly ordered
  ARM: dts: armada-38x: fix MBUS_ID for crypto SRAM on Armada 385
    Linksys

 arch/arm/boot/dts/armada-385-linksys.dtsi |  4 ++--
 arch/arm/mach-mvebu/coherency.c           | 23 +++++++++--------------
 2 files changed, 11 insertions(+), 16 deletions(-)

-- 
2.7.4
