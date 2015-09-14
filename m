From: s-anna@ti.com (Suman Anna)
Date: Mon, 14 Sep 2015 18:37:11 -0500
Subject: [PATCH 0/2] Cleanup legacy OMAP mailbox support
Message-ID: <1442273833-25013-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

The following series removes the legacy platform device creation
for OMAP mailbox devices. I will remove the platform data file
alongside the non-DT support cleanup in the driver.

Patches based on 4.3-rc1 + the patch on mach-omap2/devices.c that
removes the OMAP3 ISP instantiation in legacy-mode [1]. The hwmod
cleanup patch can be picked up independently if needed - it will
just fail to create the legacy devices in omap_init_mbox(). These
are only build tested and boot tested on OMAP3 in DT-mode, as I do
not have any platforms where I can still perform a legacy-style
boot.

regards
Suman

[1] https://patchwork.kernel.org/patch/6806891/

Suman Anna (2):
  ARM: OMAP2+: Remove legacy mailbox device instantiation
  ARM: OMAP3: hwmod data: Remove legacy mailbox data and addrs

 arch/arm/mach-omap2/devices.c              | 28 ----------------------------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 29 -----------------------------
 2 files changed, 57 deletions(-)

-- 
2.5.0
