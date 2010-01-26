From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:58:02 +0000
Subject: [PATCH] ARM: S3C2440: Fix SMDK2440 SoC selection
In-Reply-To: <1264492686-16901-1-git-send-email-ben-linux@fluff.org>
References: <1264492686-16901-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264492686-16901-4-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the entries for SMDK2440 should have allowed for S3C2440 or S3C2440
SoC selection but this depended on ARCH_S3C2440 which has not been around
for a while.

Remove the dependency to allow this to be selected.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2440/Kconfig |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index 5486929..45cab7a 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -105,14 +105,12 @@ config MACH_NEXCODER_2440
 
 config SMDK2440_CPU2440
 	bool "SMDK2440 with S3C2440 CPU module"
-	depends on ARCH_S3C2440
 	default y if ARCH_S3C2440
 	select S3C2440_XTAL_16934400
 	select CPU_S3C2440
 
 config SMDK2440_CPU2442
 	bool "SMDM2440 with S3C2442 CPU module"
-	depends on ARCH_S3C2440
 	select CPU_S3C2442
 
 config MACH_AT2440EVB
-- 
1.6.0.4
