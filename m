From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 07 Mar 2011 19:15:50 -0700
Subject: [PATCH 1/3] OMAP2/3: WKUP powerdomain: mark as being always on
In-Reply-To: <20110308021018.31946.29962.stgit@twilight.localdomain>
References: <20110308021018.31946.29962.stgit@twilight.localdomain>
Message-ID: <20110308021546.31946.87970.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark the WKUP powerdomain as being always on -- at least, as long as the
chip has power.  This will be used to enable the powerdomain code to
determine whether a given powerdomain is ever able to power off.  While
here, update the file copyright.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
index 5b4dd97..96cda13 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
@@ -2,7 +2,7 @@
  * OMAP2/3 common powerdomain definitions
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2010 Nokia Corporation
+ * Copyright (C) 2007-2011 Nokia Corporation
  *
  * Paul Walmsley, Jouni H?gander
  *
@@ -76,4 +76,5 @@ struct powerdomain wkup_omap2_pwrdm = {
 	.name		= "wkup_pwrdm",
 	.prcm_offs	= WKUP_MOD,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
+	.pwrsts		= PWRSTS_ON,
 };
