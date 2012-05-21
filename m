From: tony@atomide.com (Tony Lindgren)
Date: Mon, 21 May 2012 12:01:02 -0700
Subject: [PATCH 1/4] ARM: OMAP3: There is no FS USB controller on omap3
In-Reply-To: <20120521185323.927.88012.stgit@muffinssi.local>
References: <20120521185323.927.88012.stgit@muffinssi.local>
Message-ID: <20120521190102.927.86158.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should not select ARCH_OMAP_OTG as the hardware does not
have the legacy FS (Full Speed) USB interface.

Cc: linux-usb at vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 4cf5142..0e4dd67 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -76,7 +76,6 @@ config SOC_OMAP3430
 	bool "OMAP3430 support"
 	depends on ARCH_OMAP3
 	default y
-	select ARCH_OMAP_OTG
 
 config SOC_TI81XX
 	bool "TI81XX support"
