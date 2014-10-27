From: tony@atomide.com (Tony Lindgren)
Date: Mon, 27 Oct 2014 13:03:03 -0700
Subject: [PATCH] ARM: omap2plus_defconfig: Fix errors with NAND BCH
Message-ID: <20141027200303.GS2560@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like we need to have BCH enabled to get NAND
working and to avoid getting:

nand: error: CONFIG_MTD_NAND_ECC_BCH not enabled

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -111,6 +111,7 @@ CONFIG_MTD_OOPS=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_ECC_BCH=y
 CONFIG_MTD_NAND_OMAP2=y
 CONFIG_MTD_ONENAND=y
 CONFIG_MTD_ONENAND_VERIFY_WRITE=y
