From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 12 Jul 2013 16:49:17 +0530
Subject: [PATCH] ARM: davinci: make file local variables static
Message-ID: <1373627957-12979-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make file local variables static in mach-davinci.
This fixes sparse warnings of the form:

arch/arm/mach-davinci/dm355.c:863:27: warning: symbol 'dm355_venc_pdata' was not declared. Should it be static?

Cc: Prabhakar Lad <prabhakar.csengg@gmail.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c |    2 +-
 arch/arm/mach-davinci/dm355.c           |    2 +-
 arch/arm/mach-davinci/dm365.c           |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index fd38c8d..7e4e32f 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -505,7 +505,7 @@ static struct vpbe_output dm365evm_vpbe_outputs[] = {
 /*
  * Amplifiers on the board
  */
-struct ths7303_platform_data ths7303_pdata = {
+static struct ths7303_platform_data ths7303_pdata = {
 	.ch_1 = 3,
 	.ch_2 = 3,
 	.ch_3 = 3,
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 42ef53f..86100d1 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -860,7 +860,7 @@ static struct platform_device dm355_vpbe_display = {
 	},
 };
 
-struct venc_platform_data dm355_venc_pdata = {
+static struct venc_platform_data dm355_venc_pdata = {
 	.setup_pinmux	= dm355_vpbe_setup_pinmux,
 	.setup_clock	= dm355_venc_setup_clock,
 };
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index fa7af5e..dad2802 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1349,7 +1349,7 @@ static struct platform_device dm365_vpbe_display = {
 	},
 };
 
-struct venc_platform_data dm365_venc_pdata = {
+static struct venc_platform_data dm365_venc_pdata = {
 	.setup_pinmux	= dm365_vpbe_setup_pinmux,
 	.setup_clock	= dm365_venc_setup_clock,
 };
-- 
1.7.10.1
