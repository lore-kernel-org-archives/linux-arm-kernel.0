From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 9 Dec 2010 22:08:31 +0800
Subject: [PATCH 1/6] ARM: mx5: use config to define boot related addresses
Message-ID: <1291903716-31388-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
This series of patch support mx50 reference design board. I've tested it using
initramfs on the board.

 arch/arm/mach-mx5/Makefile.boot |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx5/Makefile.boot b/arch/arm/mach-mx5/Makefile.boot
index 9939a19..388d2e8 100644
--- a/arch/arm/mach-mx5/Makefile.boot
+++ b/arch/arm/mach-mx5/Makefile.boot
@@ -1,3 +1,3 @@
-   zreladdr-y	:= 0x90008000
-params_phys-y	:= 0x90000100
-initrd_phys-y	:= 0x90800000
+   zreladdr-$(CONFIG_SOC_IMX51)	:= 0x90008000
+params_phys-$(CONFIG_SOC_IMX51)	:= 0x90000100
+initrd_phys-$(CONFIG_SOC_IMX51)	:= 0x90800000
-- 
1.6.3.3
