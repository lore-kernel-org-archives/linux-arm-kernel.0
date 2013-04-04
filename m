From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu,  4 Apr 2013 19:46:47 +0900
Subject: [PATCH 4/4] ARM: dts: update bootargs to boot from sda2 for
 exynos5440-ssdk5440
In-Reply-To: <1365072407-4320-1-git-send-email-kgene.kim@samsung.com>
References: <1365072407-4320-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1365072407-4320-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Subash Patel <subash.rp@samsung.com>

Updated the bootargs to boot the system with rootfs in hard-disk
instead of ramdisk.

Signed-off-by: Subash Patel <subash.rp@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos5440-ssdk5440.dts |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440-ssdk5440.dts b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
index a21eb4c..d55042b 100644
--- a/arch/arm/boot/dts/exynos5440-ssdk5440.dts
+++ b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
@@ -16,12 +16,8 @@
 	model = "SAMSUNG SSDK5440 board based on EXYNOS5440";
 	compatible = "samsung,ssdk5440", "samsung,exynos5440";
 
-	memory {
-		reg = <0x80000000 0x80000000>;
-	};
-
 	chosen {
-		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x81000000,8M console=ttySAC0,115200 init=/linuxrc";
+		bootargs = "root=/dev/sda2 rw rootwait ignore_loglevel early_printk no_console_suspend mem=2048M at 0x80000000 console=ttySAC0,115200";
 	};
 
 	spi {
-- 
1.7.4.4
