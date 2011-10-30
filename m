From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 30 Oct 2011 12:56:36 +0100
Subject: [PATCH] [RESEND] [TRIVIAL] ARM: imx: Fix typo
	'MACH_MX31_3DS_MXC_NAND_USE_BBT'
Message-ID: <1319975796.14409.11.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
This is trivial because this is what apparently was intended. On the
other hand this should open code paths that were hidden until now. So
perhaps this needs the maintainer's approval. (I cannot meaningfully
test this.)

 arch/arm/mach-imx/mach-mx31_3ds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index c20be75..5750ca5 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -542,7 +542,7 @@ static const struct mxc_nand_platform_data
 mx31_3ds_nand_board_info __initconst = {
 	.width		= 1,
 	.hw_ecc		= 1,
-#ifdef MACH_MX31_3DS_MXC_NAND_USE_BBT
+#ifdef CONFIG_MACH_MX31_3DS_MXC_NAND_USE_BBT
 	.flash_bbt	= 1,
 #endif
 };
-- 
1.7.4.4
