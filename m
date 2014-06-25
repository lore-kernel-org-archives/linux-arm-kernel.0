From: s-anna@ti.com (Suman Anna)
Date: Tue, 24 Jun 2014 19:43:36 -0500
Subject: [PATCH 0/7] OMAP mailbox cleanup
Message-ID: <1403657023-53897-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series is mainly a cleanup of the current OMAP mailbox drivers
in preparation for adding DT support and adoption to the upcoming mailbox
framework from Jassi Brar [1]. It removes the OMAP1 mailbox driver as there
are no users for it in the kernel, and consolidates the previous OMAP
mailbox framework and the OMAP2+ mailbox driver into a single OMAP mailbox
driver. 

The last patch also allows the OMAP mailbox driver to support multiple
instances of the IP (for DRA7xx, which is the first SoC in the OMAP family
to have more than one System Mailbox IP).

The patches are based on 3.16-rc2 and do not change any of the functional
behavior on any OMAP2+ SoCs. The boot logs on various OMAP platforms with
these patches are at:
  OMAP2 (SDP2430)           : http://slexy.org/view/s20rOAReeS
  OMAP3 (BeagleXM)          : http://slexy.org/view/s2QITyvzH9
  OMAP4 (PandaBoard)        : http://slexy.org/view/s2X9jdZ9Wh
  OMAP5 (OMAP5 uEVM)        : http://slexy.org/view/s21hZUTYwm
  DRA7  (DRA7 EVM)          : http://slexy.org/view/s213K7f87s
  AM33xx (BeagleBone Black) : http://slexy.org/view/s2vB7oxbix
  AM43xx (AM437x GP EVM)    : http://slexy.org/view/s21rMlUWMg

[1] https://lkml.org/lkml/2014/6/12/470

Suman Anna (7):
  mailbox/omap: use devm_* interfaces
  mailbox/omap: remove OMAP1 mailbox driver
  mailbox/omap: remove omap_mbox_type_t from mailbox ops
  mailbox/omap: simplify the fifo assignment by using macros
  mailbox/omap: consolidate OMAP mailbox driver
  mailbox/omap: remove the private mailbox structure
  mailbox/omap: add a parent structure for every IP instance

 arch/arm/configs/omap1_defconfig |   2 -
 drivers/mailbox/Kconfig          |  19 +-
 drivers/mailbox/Makefile         |   6 +-
 drivers/mailbox/mailbox-omap1.c  | 203 ------------------
 drivers/mailbox/mailbox-omap2.c  | 357 -------------------------------
 drivers/mailbox/omap-mailbox.c   | 444 +++++++++++++++++++++++++++++++--------
 drivers/mailbox/omap-mbox.h      |  67 ------
 7 files changed, 360 insertions(+), 738 deletions(-)
 delete mode 100644 drivers/mailbox/mailbox-omap1.c
 delete mode 100644 drivers/mailbox/mailbox-omap2.c
 delete mode 100644 drivers/mailbox/omap-mbox.h

-- 
2.0.0
