From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 18 Nov 2009 04:34:22 -0700
Subject: [PATCH 0/4] OMAP hwmod improvements for 2.6.33
Message-ID: <20091118113212.8617.3864.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

here are some updates for the OMAP hardware module code for 2.6.33.
There are likely to be more after these, but am posting these early for
comments and for other branch maintainers who are interested to use in
their trees.


- Paul

---

Paul Walmsley (4):
      OMAP3 hwmod: reprogram OCP_SYSCONFIG register after setting SOFTRESET
      OMAP3 hwmod: Add automatic OCP_SYSCONFIG AUTOIDLE handling
      OMAP hwmod: add names to module MPU IRQ lines
      OMAP3 hwmod: drop most of the OCP_SYSCONFIG.CLOCKACTIVITY code


 arch/arm/mach-omap2/omap_hwmod.c             |  148 ++++++++++----------------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   26 ++++-
 2 files changed, 79 insertions(+), 95 deletions(-)
