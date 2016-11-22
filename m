From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 22 Nov 2016 09:26:00 +0000
Subject: [RFC PATCH 03/11] ARM: omap: do not select HIGHMEM explicitly
In-Reply-To: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1479806768-39911-4-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Explicit selection of HIGHMEM breaks NOMMU builds. It seems that
HIGHMEM is user selectable option, so probably it would be better to
let user to make a decision on this options or, at least, move it to
defconfig.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mach-omap2/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index a9afeeb..4e3fb69 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -120,7 +120,6 @@ config ARCH_OMAP2PLUS_TYPICAL
 	bool "Typical OMAP configuration"
 	default y
 	select AEABI
-	select HIGHMEM
 	select I2C
 	select I2C_OMAP
 	select MENELAUS if ARCH_OMAP2
-- 
1.7.9.5
