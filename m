From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Mon, 28 Jul 2014 10:23:55 +0530
Subject: [PATCH v2 0/2] ARM: DRA7: hwmod: Add dra74x and dra72x specific ocp
 interface lists
Message-ID: <1406523237-6905-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add seperate ocp interface lists that are specific to dra74x
and dra72x, and moving USB OTG SS4 to dra74x only since its not present
in dra72x. Without this USB OTG SS4 hwmod gives an abort on dra72x.

Adding support for soc_is_dra74x() and soc_is_dra72x() in order to differentiate
between dra74x and dra72x and pass the respective ocp interface lists.

Without this dra72x is crashing on linux-next.
Verified on dra74x evm and dra72x evm using 20140725 linux-next.

dra74x : http://paste.ubuntu.com/7881342/
dra72x : http://paste.ubuntu.com/7881349/

Rajendra Nayak (2):
  ARM: DRA7: Add support for soc_is_dra74x() and soc_is_dra72x()
    variants
  ARM: DRA7: hwmod: Add dra74x and dra72x specific ocp interface lists

 arch/arm/mach-omap2/omap_hwmod.c          |  3 +++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 22 ++++++++++++++++++++--
 arch/arm/mach-omap2/soc.h                 |  6 ++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

-- 
1.9.1
