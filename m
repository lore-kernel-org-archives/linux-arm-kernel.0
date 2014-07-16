From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Wed, 16 Jul 2014 14:06:12 +0530
Subject: [PATCH 0/2] ARM: DRA7: hwmod: Add dra74x and dra72x specific ocp
 interface lists
Message-ID: <1405499774-19770-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add seperate ocp interface lists that are specific to dra74x
and dra72x, and moving USB OTG SS4 to dra74x only since its not present
in dra72x. Without this USB OTG SS4 hwmod gives an abort on dra72x.

Adding support for soc_is_dra74x() and soc_is_dra72x() in order to differentiate
between dra74x and dra72x and pass the respective ocp interface lists.

Verified on dra74x evm and dra72x evm using 3.16-rc5 based mainline kernel.

Before:
dra74x : http://paste.ubuntu.com/7802364/ 
dra72x : http://paste.ubuntu.com/7802334/ (Kernel panic)

After-
dra74x : http://paste.ubuntu.com/7802340/
dra72x : http://paste.ubuntu.com/7802338/ (booted)

Rajendra Nayak (2):
  ARM: DRA7: Add support for soc_is_dra74x() and soc_is_dra72x()
    varients
  ARM: DRA7: hwmod: Add dra74x and dra72x specific ocp interface lists

 arch/arm/mach-omap2/omap_hwmod.c          |    3 +++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |   22 ++++++++++++++++++++--
 arch/arm/mach-omap2/soc.h                 |    7 +++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

-- 
1.7.9.5
