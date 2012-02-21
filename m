From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Tue, 21 Feb 2012 11:42:58 +0100
Subject: [PATCH 09/12] ARM: S3C2416: move mach-s3c2416/* into mach-s3c24xx/
In-Reply-To: <1329346545-16373-10-git-send-email-kgene.kim@samsung.com>
References: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
 <1329346545-16373-10-git-send-email-kgene.kim@samsung.com>
Message-ID: <201202211142.59542.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

Am Mittwoch, 15. Februar 2012, 23:55:43 schrieb Kukjin Kim:
> This patch moves S3C2416 stuff into mach-s3c24xx/ directory
> so that we can merge the s3c24 series' directories to the
> just one mach-s3c24xx/ directory.
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
the patch is missing something like the following to prevent an error because 
"built-in.o" in mach-s3c2416 cannot be found:


diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index f3f6d97..2e46fe9 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -175,7 +175,7 @@ machine-$(CONFIG_ARCH_PRIMA2)               := prima2
 machine-$(CONFIG_ARCH_PXA)             := pxa
 machine-$(CONFIG_ARCH_REALVIEW)                := realview
 machine-$(CONFIG_ARCH_RPC)             := rpc
-machine-$(CONFIG_ARCH_S3C24XX)         := s3c24xx s3c2412 s3c2416 s3c2440
+machine-$(CONFIG_ARCH_S3C24XX)         := s3c24xx s3c2412 s3c2440
 machine-$(CONFIG_ARCH_S3C64XX)         := s3c64xx
 machine-$(CONFIG_ARCH_S5P64X0)         := s5p64x0
 machine-$(CONFIG_ARCH_S5PC100)         := s5pc100


Heiko
