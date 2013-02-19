From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Feb 2013 11:56:05 +0900
Subject: [PATCH 0/5] ARM: shmobile: r8a7779 and marzen initialisation
 enhancements
Message-ID: <1361242570-8867-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series:

* Removes the use of early devices from reference marzen reference DT
* Initialises i2c as a late device (non reference DT boot)
* Moves ethernet controller from SoC to marzen board DT file

Merge:

My plan to merge this is:
* Add r8a7779 patches to an soc branch.
* Rebase a boards branch on top of the soc branch.
* Apply marzen patches, squashing them to into existing commits
  to avoid breaking bisection.

Simon Horman (5):
  ARM: shmobile: r8a7779: Do not use early devices with DT reference
  ARM: shmobile: marzen: Do not use early devices
  ARM: shmobile: r8a7779: Do not initialise i2c as an early device
  ARM: shmobile: r8a7779: Remove lan from dtsi
  ARM: shmobile: marzen: Add lan to dts file

 arch/arm/boot/dts/r8a7779-marzen-reference.dts  |   14 +++++++---
 arch/arm/boot/dts/r8a7779.dtsi                  |    9 -------
 arch/arm/mach-shmobile/board-marzen-reference.c |    2 +-
 arch/arm/mach-shmobile/include/mach/common.h    |    2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c          |   33 +++++++++--------------
 5 files changed, 24 insertions(+), 36 deletions(-)

-- 
1.7.10.4
