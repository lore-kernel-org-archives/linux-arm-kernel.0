From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 13 Sep 2012 19:36:44 +0300
Subject: [PATCHv8 0/5] ARM: OMAP4: core retention support
Message-ID: <1347554209-23378-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes compared to previous version:

- Dropped following patches from the set as these were queued by Paul:
0003-ARM-OMAP4-hwmod-flag-hwmods-modules-not-supporting-m.patch
0004-ARM-OMAP-hwmod-Add-support-for-per-hwmod-module-cont.patch
0005-ARM-OMAP4-pwrdm-add-support-for-reading-prev-logic-a.patch
0009-ARM-OMAP4-hwmod-data-temporarily-comment-out-data-fo.patch
0010-ARM-OMAP4-HWMOD-add-support-for-lostcontext_mask.patch

- Dropped following patches for now as their need is not that clear at
  the moment:
0011-ARM-OMAP4-hwmod_data-add-context-lose-information-fo.patch
0012-ARM-OMAP4-hwmod-update-context-lost-counter-logic-fo.patch

- Rebased on top of func-pwrst-v6 from Jean and 3.6-rc5.

- Added patch #5 for yet another bug fix: the fix for the omap4460
  (patch #2) is incomplete, and can cause rare TWD timer bugs. This
  patch fixes those.

- Tested with omap4460 GP panda + omap4430 EMU blaze, with suspend +
  cpuidle.

Branch also available here (it also has the func pwrst code + the queued
hwmod patches as the code doesn't apply cleanly / work without these.)

Tree: git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
Branch: mainline-3.6-rc5-omap4-ret-v8

-Tero
