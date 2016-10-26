From: abailon@baylibre.com (Alexandre Bailon)
Date: Wed, 26 Oct 2016 14:39:01 +0200
Subject: [PATCH v3] Fix some potential warnings
Message-ID: <1477485542-10555-1-git-send-email-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some changes I'm working on causes some warning because two included
headers defines the same macros.

Change in V2:
Update the d830 evm board file to use the da8xx-cfgchip.h
These changes are required as I'm sending this patch apart from
the series "[PATCH/RFT v2 00/17] Add DT support for ohci-da8xx"

Change in v3:
Fix build issues happening in omapl138 hawk and da830 evm board files.

Alexandre Bailon (1):
  ARM: davinci: da8xx: Fix some redefined symbol warnings

 arch/arm/mach-davinci/board-da830-evm.c     |  5 +++--
 arch/arm/mach-davinci/board-omapl138-hawk.c |  3 ++-
 include/linux/platform_data/usb-davinci.h   | 23 -----------------------
 3 files changed, 5 insertions(+), 26 deletions(-)

-- 
2.7.3
