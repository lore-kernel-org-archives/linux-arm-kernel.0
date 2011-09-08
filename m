From: jason.hui@linaro.org (Jason Liu)
Date: Thu, 8 Sep 2011 11:27:26 +0800
Subject: [PATCH v3 3/4] ARM: i.MX5/mm: add the TZIC mapping resource
In-Reply-To: <1315452447-20205-1-git-send-email-jason.hui@linaro.org>
References: <1315452447-20205-1-git-send-email-jason.hui@linaro.org>
Message-ID: <1315452447-20205-4-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the TZIC mapping size and also add missing static mapping
comments for the i.mx53 part

Signed-off-by: Jason Liu <jason.hui@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/hardware.h |    6 ++++++
 arch/arm/plat-mxc/include/mach/mx51.h     |    1 +
 arch/arm/plat-mxc/include/mach/mx53.h     |    1 +
 3 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index 33728aa..d1ba212 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -81,10 +81,16 @@
  *	AIPS1	0x53f00000+0x100000	->	0xf5700000+0x100000
  *	AIPS2	0x63f00000+0x100000	->	0xf5300000+0x100000
  * mx51:
+ *	TZIC	0xe0000000+0x004000	->	0xf5000000+0x004000
  *	IRAM	0x1ffe0000+0x020000	->	0xf4fe0000+0x020000
  *	SPBA0	0x70000000+0x100000	->	0xf5400000+0x100000
  *	AIPS1	0x73f00000+0x100000	->	0xf5700000+0x100000
  *	AIPS2	0x83f00000+0x100000	->	0xf4300000+0x100000
+ * mx53:
+ *	TZIC	0x0FFFC000+0x004000	->	0xf4bfc000+0x004000
+ *	SPBA0	0x50000000+0x100000	->	0xf5400000+0x100000
+ *	AIPS1	0x53F00000+0x100000	->	0xf5700000+0x100000
+ *	AIPS2	0x63F00000+0x100000	->	0xf5300000+0x100000
  */
 #define IMX_IO_P2V(x)	(						\
 			0xf4000000 +					\
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index 652f2b0..8da9d7a 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -120,6 +120,7 @@
 
 #define MX51_GPU2D_BASE_ADDR		0xd0000000
 #define MX51_TZIC_BASE_ADDR		0xe0000000
+#define MX51_TZIC_SIZE			SZ_16K
 
 #define MX51_IO_P2V(x)			IMX_IO_P2V(x)
 #define MX51_IO_ADDRESS(x)		IOMEM(MX51_IO_P2V(x))
diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/plat-mxc/include/mach/mx53.h
index 5e3c323..fbf2610 100644
--- a/arch/arm/plat-mxc/include/mach/mx53.h
+++ b/arch/arm/plat-mxc/include/mach/mx53.h
@@ -9,6 +9,7 @@
 
 /* TZIC */
 #define MX53_TZIC_BASE_ADDR		0x0FFFC000
+#define MX53_TZIC_SIZE                  SZ_16K
 
 /*
  * AHCI SATA
-- 
1.7.4.1
