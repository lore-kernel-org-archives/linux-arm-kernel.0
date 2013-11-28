From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 17:54:29 +0900
Subject: [PATCH 05/16] ARM: shmobile: sh73a0: don't use named resource for I2C
In-Reply-To: <cover.1385628709.git.horms+renesas@verge.net.au>
References: <cover.1385628709.git.horms+renesas@verge.net.au>
Message-ID: <8e85524bf5a2a6bf35a5011bd1cd116650da5c47.1385628709.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

i2c-sh_mobile driver doesn't care resource name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index b7ce68e..c515801 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -316,7 +316,7 @@ static struct platform_device tmu01_device = {
 };
 
 static struct resource i2c0_resources[] = {
-	[0] = DEFINE_RES_MEM_NAMED(0xe6820000, 0x426, "IIC0"),
+	[0] = DEFINE_RES_MEM(0xe6820000, 0x426),
 	[1] = {
 		.start	= gic_spi(167),
 		.end	= gic_spi(170),
@@ -325,7 +325,7 @@ static struct resource i2c0_resources[] = {
 };
 
 static struct resource i2c1_resources[] = {
-	[0] = DEFINE_RES_MEM_NAMED(0xe6822000, 0x426, "IIC1"),
+	[0] = DEFINE_RES_MEM(0xe6822000, 0x426),
 	[1] = {
 		.start	= gic_spi(51),
 		.end	= gic_spi(54),
@@ -334,7 +334,7 @@ static struct resource i2c1_resources[] = {
 };
 
 static struct resource i2c2_resources[] = {
-	[0] = DEFINE_RES_MEM_NAMED(0xe6824000, 0x426, "IIC2"),
+	[0] = DEFINE_RES_MEM(0xe6824000, 0x426),
 	[1] = {
 		.start	= gic_spi(171),
 		.end	= gic_spi(174),
@@ -343,7 +343,7 @@ static struct resource i2c2_resources[] = {
 };
 
 static struct resource i2c3_resources[] = {
-	[0] = DEFINE_RES_MEM_NAMED(0xe6826000, 0x426, "IIC3"),
+	[0] = DEFINE_RES_MEM(0xe6826000, 0x426),
 	[1] = {
 		.start	= gic_spi(183),
 		.end	= gic_spi(186),
@@ -352,7 +352,7 @@ static struct resource i2c3_resources[] = {
 };
 
 static struct resource i2c4_resources[] = {
-	[0] = DEFINE_RES_MEM_NAMED(0xe6828000, 0x426, "IIC4"),
+	[0] = DEFINE_RES_MEM(0xe6828000, 0x426),
 	[1] = {
 		.start	= gic_spi(187),
 		.end	= gic_spi(190),
-- 
1.8.4
