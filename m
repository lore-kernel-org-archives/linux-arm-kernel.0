From: govindraj.raja@ti.com (Govindraj.R)
Date: Wed, 21 Mar 2012 15:54:58 +0530
Subject: [PATCH 0/3] OMAP2+: UART: Enable tx wakeup + remove cpu checks
Message-ID: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Govindraj.R" <govindraj.raja@ti.com>

Based on Linux-OMAP tree uart branch.
(git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
remotes/origin/uart)

* Removes the cpu checks wherever possible and use version reg
  for populating features and errata's
* enable tx wakeup available in wer reg for applicable
  module revision's

Govindraj.R (3):
  OMAP2+: UART: Remove cpu checks for populating errata flags
  OMAP2+: UART: enable tx wakeup bit for wer reg
  OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not omap24xx

 arch/arm/mach-omap2/serial.c                  |   13 +----
 arch/arm/plat-omap/include/plat/omap-serial.h |    8 +++-
 drivers/tty/serial/omap-serial.c              |   71 ++++++++++++++++++++++++-
 3 files changed, 78 insertions(+), 14 deletions(-)

-- 
1.7.5.4
