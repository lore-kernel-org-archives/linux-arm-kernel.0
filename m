From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Apr 2016 16:46:21 -0700
Subject: [PATCH 0/2] Pass n900 MMC slot names in pdata for legacy user space
Message-ID: <1461714383-9956-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

N900 needs the MMC slot names to work. Let's pass them in pdata
for now to remove the last remaining blocker for removing omap3
legacy booting support for v4.8.

Then when we have a generic DT binding for the slot names, we
can use that assuming it will work for the n900 legacy user space.

Regards,

Tony


Tony Lindgren (2):
  ARM: OMAP2+: n900 needs MMC slot names for legacy user space
  mmc: omap_hsmmc: Check if MMC slot name is passed in pdata

 arch/arm/mach-omap2/pdata-quirks.c | 7 +++++++
 drivers/mmc/host/omap_hsmmc.c      | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.8.1
