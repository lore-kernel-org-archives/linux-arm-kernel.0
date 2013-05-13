From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 13 May 2013 17:04:22 +0000 (UTC)
Subject: [PATCH] ARM: defconfigs: OMAP: omap2plus_defconfig missing
 CONFIG_ARCH_MULTI_V6=y
In-Reply-To: <alpine.DEB.2.00.1305131701270.7156@utopia.booyaka.com>
References: <alpine.DEB.2.00.1305131701270.7156@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1305131703271.7156@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 May 2013, Paul Walmsley wrote:

> Fix by setting CONFIG_ARCH_MULTI_V7.

Well, obvious typo here.  Here's the updated version.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Mon, 13 May 2013 10:47:48 -0600
Subject: [PATCH] ARM: defconfigs: OMAP: omap2plus_defconfig missing CONFIG_ARCH_MULTI_V6=y

omap2plus_defconfig is missing CONFIG_ARCH_MULTI_V6.  This results in
undefined instruction traps in u-boot (and boot failures) on OMAP2xxx
SoCs, which are ARM11-based.  Fix by setting CONFIG_ARCH_MULTI_V6.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index c1ef64b..f590902 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -20,6 +20,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
+CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_OMAP_MUX_DEBUG=y
-- 
1.7.10.4
