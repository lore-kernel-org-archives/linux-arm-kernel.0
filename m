From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 31 May 2012 16:55:36 +0300
Subject: [PATCHv6 00/14] ARM: OMAP3+: auto ret / auto off support
Message-ID: <1338472550-20743-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set applies on top of the pwrdm / voltdm usecounting fixes set.
Contains some fixes proposed mainly by Nishanth Menon <nm@ti.com>.

http://marc.info/?l=linux-omap&m=133847159830867&w=2

Changes compared to previous version:

- huge patch #3 in set v5 was split into patches 3...6
- dropped omap4 pmic_setup time params, as they are currently not needed
  (reset value is okay for these), once a board that requires support for
  this is added, the oscillator setup time calculations should be modified
  as the pmic_setup time is actually impacting these

patch 1:
 - changed calculation to use DIV_ROUND_UP

patch 2:
 - changed the patch not to alter the parameters, just rename them

patch 3...6:
 - split from patch #3
 - separated omap3 / omap4 specific code to their own patches
 - added support for voltsetup_off_reg for omap4

patch 7:
 - added error check against null pointers

patch 9:
 - use DIV_ROUND_UP_ULL instead of manual formula

patch 10:
 - new patch, originally part of patch #2

patch set available also via git:
tree: git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.4-voltdm-v6

Tested on omap3 beagle, boot tested on omap4460 panda es.

-Tero
