From: nm@ti.com (Nishanth Menon)
Date: Mon,  3 Jan 2011 12:58:29 -0600
Subject: [PATCH 1/2] OMAP2+: TWL: make conversion routines static
In-Reply-To: <1294081110-23695-1-git-send-email-nm@ti.com>
References: <1294081110-23695-1-git-send-email-nm@ti.com>
Message-ID: <1294081110-23695-2-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The uv_to_vsel, vsel_to_uv functions don't need to be exposed to the
world as they are used as function pointers. make them static.

Fixes sparse warnings:
arch/arm/mach-omap2/omap_twl.c:63:15: warning: symbol 'twl4030_vsel_to_uv' was not declared. Should it be static?
arch/arm/mach-omap2/omap_twl.c:68:4: warning: symbol 'twl4030_uv_to_vsel' was not declared. Should it be static?
arch/arm/mach-omap2/omap_twl.c:73:15: warning: symbol 'twl6030_vsel_to_uv' was not declared. Should it be static?
arch/arm/mach-omap2/omap_twl.c:105:4: warning: symbol 'twl6030_uv_to_vsel' was not declared. Should it be static?

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 15f8c6c..65ab4e3 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -60,17 +60,17 @@ static u8 smps_offset;
 
 #define REG_SMPS_OFFSET         0xE0
 
-unsigned long twl4030_vsel_to_uv(const u8 vsel)
+static unsigned long twl4030_vsel_to_uv(const u8 vsel)
 {
 	return (((vsel * 125) + 6000)) * 100;
 }
 
-u8 twl4030_uv_to_vsel(unsigned long uv)
+static u8 twl4030_uv_to_vsel(unsigned long uv)
 {
 	return DIV_ROUND_UP(uv - 600000, 12500);
 }
 
-unsigned long twl6030_vsel_to_uv(const u8 vsel)
+static unsigned long twl6030_vsel_to_uv(const u8 vsel)
 {
 	/*
 	 * In TWL6030 depending on the value of SMPS_OFFSET
@@ -102,7 +102,7 @@ unsigned long twl6030_vsel_to_uv(const u8 vsel)
 		return ((((vsel - 1) * 125) + 6000)) * 100;
 }
 
-u8 twl6030_uv_to_vsel(unsigned long uv)
+static u8 twl6030_uv_to_vsel(unsigned long uv)
 {
 	/*
 	 * In TWL6030 depending on the value of SMPS_OFFSET
-- 
1.6.3.3
