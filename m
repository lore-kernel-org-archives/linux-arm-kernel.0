From: robherring2@gmail.com (Rob Herring)
Date: Wed, 14 Dec 2011 09:28:55 -0600
Subject: [PATCH 6/9] ARM: realview: convert pl061 no irq to 0 instead of -1
In-Reply-To: <1323876538-20406-1-git-send-email-robherring2@gmail.com>
References: <1323876538-20406-1-git-send-email-robherring2@gmail.com>
Message-ID: <1323876538-20406-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Drivers should use 0 for no irq, so convert realview platforms pl061
platform_data over to use 0.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-realview/realview_eb.c     |    3 ---
 arch/arm/mach-realview/realview_pb1176.c |    3 ---
 arch/arm/mach-realview/realview_pb11mp.c |    3 ---
 arch/arm/mach-realview/realview_pba8.c   |    3 ---
 arch/arm/mach-realview/realview_pbx.c    |    3 ---
 5 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 026c66a..57f5bac 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -117,17 +117,14 @@ static void __init realview_eb_map_io(void)
 
 static struct pl061_platform_data gpio0_plat_data = {
 	.gpio_base	= 0,
-	.irq_base	= -1,
 };
 
 static struct pl061_platform_data gpio1_plat_data = {
 	.gpio_base	= 8,
-	.irq_base	= -1,
 };
 
 static struct pl061_platform_data gpio2_plat_data = {
 	.gpio_base	= 16,
-	.irq_base	= -1,
 };
 
 static struct pl022_ssp_controller ssp0_plat_data = {
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index c057540..2267696 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -113,17 +113,14 @@ static void __init realview_pb1176_map_io(void)
 
 static struct pl061_platform_data gpio0_plat_data = {
 	.gpio_base	= 0,
-	.irq_base	= -1,
 };
 
 static struct pl061_platform_data gpio1_plat_data = {
 	.gpio_base	= 8,
-	.irq_base	= -1,
 };
 
 static struct pl061_platform_data gpio2_plat_data = {
 	.gpio_base	= 16,
-	.irq_base	= -1,
 };
 
 static struct pl022_ssp_controller ssp0_plat_data = {
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 671ad6d..8622dbb 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -112,17 +112,14 @@ static void __init realview_pb11mp_map_io(void)
 
 static struct pl061_platform_data gpio0_plat_data = {
 	.gpio_base	= 0,
-	.irq_base	= -1,
 };
 
 static struct pl061_platform_data gpio1_plat_data = {
 	.gpio_base	= 8,
-	.irq_base	= -1,
 };
 
 static struct pl061_platform_data gpio2_plat_data = {
 	.gpio_base	= 16,
-	.irq_base	= -1,
 };
 
 static struct pl022_ssp_controller ssp0_plat_data = {
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index cbf22df..6f9511d 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -102,17 +102,14 @@ static void __init realview_pba8_map_io(void)
 
 static struct pl061_platform_data gpio0_plat_data = {
 	.gpio_base	= 0,
-	.irq_base	= -1,
 };
 
 static struct pl061_platform_data gpio1_plat_data = {
 	.gpio_base	= 8,
-	.irq_base	= -1,
 };
 
 static struct pl061_platform_data gpio2_plat_data = {
 	.gpio_base	= 16,
-	.irq_base	= -1,
 };
 
 static struct pl022_ssp_controller ssp0_plat_data = {
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 63c4114..be3a01f 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -124,17 +124,14 @@ static void __init realview_pbx_map_io(void)
 
 static struct pl061_platform_data gpio0_plat_data = {
 	.gpio_base	= 0,
-	.irq_base	= -1,
 };
 
 static struct pl061_platform_data gpio1_plat_data = {
 	.gpio_base	= 8,
-	.irq_base	= -1,
 };
 
 static struct pl061_platform_data gpio2_plat_data = {
 	.gpio_base	= 16,
-	.irq_base	= -1,
 };
 
 static struct pl022_ssp_controller ssp0_plat_data = {
-- 
1.7.5.4
