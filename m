From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 25 Nov 2013 17:26:43 +0100
Subject: [PATCH 0/4] ARM: mvebu: misc important fixes
Message-ID: <1385396807-19027-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Andrew, Greg, Sebastian,

Here are four important fixes for Armada 370/XP support:

 * Two fixes for the irqchip driver, fixing a similar problem in the
   IPI and MSI implementation. I've splitted the patches in two,
   because the IPI side of the fix should normally be backported all
   the way to 3.8, while the MSI side of the fix is only needed in
   3.13, since MSI support didn't exist before. The IPI problem causes
   some really nasty SMP scheduling problems.

 * One fix for the I/O coherency, which should be backported all the
   way to 3.8.

 * One fix for the PCIe controller on Armada 370 DB, which should be
   backported to 3.12, where the problem was introduced.

Thanks to Lior Amsalem for debugging the IPI issue, and Gregory
Clement for finding the I/O coherency register address problem.

Thomas

Gregory CLEMENT (1):
  ARM: mvebu: use the virtual CPU registers to access coherency
    registers

Lior Amsalem (2):
  irqchip: armada-370-xp: fix IPI race condition
  irqchip: armada-370-xp: fix MSI race condition

Thomas Petazzoni (1):
  ARM: mvebu: re-enable PCIe on Armada 370 DB

 arch/arm/boot/dts/armada-370-db.dts  | 28 ++++++++++++++--------------
 arch/arm/boot/dts/armada-370-xp.dtsi |  2 +-
 drivers/irqchip/irq-armada-370-xp.c  |  4 ++--
 3 files changed, 17 insertions(+), 17 deletions(-)

-- 
1.8.1.2
