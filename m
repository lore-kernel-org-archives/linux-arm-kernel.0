From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 Aug 2010 11:02:14 +0300
Subject: [PATCH 6/6] omap: Fix omap_4430sdp_defconfig for make oldconfig
In-Reply-To: <20100813080034.18750.15410.stgit@baageli.muru.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>
Message-ID: <20100813080213.18750.41042.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ffb63e3402849e1b70119ee0c9a81dc9da4dfa97 changed
Kconfig to select support for omap2, 3 and 4 by default.

However, CONFIG_SMP won't currently work properly on
uniprocessor ARMs, or if support for earlier ARM cores
is selected in.

Fix this by updating omap_4430sdp_defconfig to not
select omap2 or 3 at this point.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index 63e0c2d..14c1e18 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -13,6 +13,9 @@ CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_OMAP=y
 CONFIG_ARCH_OMAP4=y
+# CONFIG_ARCH_OMAP2PLUS_TYPICAL is not set
+# CONFIG_ARCH_OMAP2 is not set
+# CONFIG_ARCH_OMAP3 is not set
 # CONFIG_OMAP_MUX is not set
 CONFIG_OMAP_32K_TIMER=y
 CONFIG_OMAP_DM_TIMER=y
