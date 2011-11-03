From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 3 Nov 2011 16:24:22 +0530
Subject: [PATCH 0/3] Support omap_pm_get_dev_context_loss_count() for OMAP4
Message-ID: <1320317665-6381-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds support for OMAP-PM api omap_pm_get_dev_context_loss_count()
on OMAP4 platforms. This api is mainly used by drivers to determine if the
device context was lost, before doing a restore.

regards,
Rajendra

Rajendra Nayak (3):
  ARM: OMAP: hmwod: Add support for per hwmod/module context lost count
  ARM: OMAP: hwmod: Update/Clear module specific context lost counters
  ARM: OMAP: hwmod: Look for hwmod/module level context lost count if
    supported

 arch/arm/mach-omap2/omap_hwmod.c             |   39 ++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 2 files changed, 38 insertions(+), 3 deletions(-)
