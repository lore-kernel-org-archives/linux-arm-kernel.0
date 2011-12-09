From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Dec 2011 17:51:22 -0800
Subject: [PATCH] ARM: OMAP1: Set the omap1623 sram size to 16K
In-Reply-To: <1322686675-26855-1-git-send-email-jkrzyszt@tis.icnet.pl>
References: <20111128174508.GO31337@atomide.com>
 <1322686675-26855-1-git-send-email-jkrzyszt@tis.icnet.pl>
Message-ID: <20111209015122.GM31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we're always reprogramming the core clock we must make
sure SRAM works. It seems that neither omap1621 or omap1623
has 256K of SRAM. Set the SRAM size to safe value of 16K.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -141,11 +141,9 @@ static void __init omap_detect_sram(void)
 			omap_sram_size = 0x32000;	/* 200K */
 		else if (cpu_is_omap15xx())
 			omap_sram_size = 0x30000;	/* 192K */
-		else if (cpu_is_omap1610() || cpu_is_omap1621() ||
-		     cpu_is_omap1710())
+		else if (cpu_is_omap1610() || cpu_is_omap1611() ||
+				cpu_is_omap1621() || cpu_is_omap1710())
 			omap_sram_size = 0x4000;	/* 16K */
-		else if (cpu_is_omap1611())
-			omap_sram_size = SZ_256K;
 		else {
 			pr_err("Could not detect SRAM size\n");
 			omap_sram_size = 0x4000;
