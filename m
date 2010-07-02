From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 02 Jul 2010 09:29:21 -0600
Subject: [PATCH 07/20] OMAP2&3: hwmod: Remove _hwmod prefix in name string
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Message-ID: <20100702152920.6221.86072.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benoit Cousson <b-cousson@ti.com>

In the lastest OMAP4 hwmod data file, the _hwmod was removed
in order to save some memory space and because it does not
bring a lot.
Align OMAP2420, 2430 and 3430 data files with the same convention.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    6 +++---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 +++---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a8b57a6..646386c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -59,7 +59,7 @@ static struct omap_hwmod_ocp_if *omap2420_l3_masters[] = {
 
 /* L3 */
 static struct omap_hwmod omap2420_l3_hwmod = {
-	.name		= "l3_hwmod",
+	.name		= "l3_main",
 	.class		= &l3_hwmod_class,
 	.masters	= omap2420_l3_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2420_l3_masters),
@@ -90,7 +90,7 @@ static struct omap_hwmod_ocp_if *omap2420_l4_core_masters[] = {
 
 /* L4 CORE */
 static struct omap_hwmod omap2420_l4_core_hwmod = {
-	.name		= "l4_core_hwmod",
+	.name		= "l4_core",
 	.class		= &l4_hwmod_class,
 	.masters	= omap2420_l4_core_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2420_l4_core_masters),
@@ -111,7 +111,7 @@ static struct omap_hwmod_ocp_if *omap2420_l4_wkup_masters[] = {
 
 /* L4 WKUP */
 static struct omap_hwmod omap2420_l4_wkup_hwmod = {
-	.name		= "l4_wkup_hwmod",
+	.name		= "l4_wkup",
 	.class		= &l4_hwmod_class,
 	.masters	= omap2420_l4_wkup_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2420_l4_wkup_masters),
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 8b1f74b..b2100cf 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -59,7 +59,7 @@ static struct omap_hwmod_ocp_if *omap2430_l3_masters[] = {
 
 /* L3 */
 static struct omap_hwmod omap2430_l3_hwmod = {
-	.name		= "l3_hwmod",
+	.name		= "l3_main",
 	.class		= &l3_hwmod_class,
 	.masters	= omap2430_l3_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2430_l3_masters),
@@ -92,7 +92,7 @@ static struct omap_hwmod_ocp_if *omap2430_l4_core_masters[] = {
 
 /* L4 CORE */
 static struct omap_hwmod omap2430_l4_core_hwmod = {
-	.name		= "l4_core_hwmod",
+	.name		= "l4_core",
 	.class		= &l4_hwmod_class,
 	.masters	= omap2430_l4_core_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2430_l4_core_masters),
@@ -113,7 +113,7 @@ static struct omap_hwmod_ocp_if *omap2430_l4_wkup_masters[] = {
 
 /* L4 WKUP */
 static struct omap_hwmod omap2430_l4_wkup_hwmod = {
-	.name		= "l4_wkup_hwmod",
+	.name		= "l4_wkup",
 	.class		= &l4_hwmod_class,
 	.masters	= omap2430_l4_wkup_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2430_l4_wkup_masters),
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index e288b20..ec6a5f8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -70,7 +70,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l3_masters[] = {
 
 /* L3 */
 static struct omap_hwmod omap3xxx_l3_hwmod = {
-	.name		= "l3_hwmod",
+	.name		= "l3_main",
 	.class		= &l3_hwmod_class,
 	.masters	= omap3xxx_l3_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l3_masters),
@@ -101,7 +101,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_core_masters[] = {
 
 /* L4 CORE */
 static struct omap_hwmod omap3xxx_l4_core_hwmod = {
-	.name		= "l4_core_hwmod",
+	.name		= "l4_core",
 	.class		= &l4_hwmod_class,
 	.masters	= omap3xxx_l4_core_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_core_masters),
@@ -122,7 +122,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_per_masters[] = {
 
 /* L4 PER */
 static struct omap_hwmod omap3xxx_l4_per_hwmod = {
-	.name		= "l4_per_hwmod",
+	.name		= "l4_per",
 	.class		= &l4_hwmod_class,
 	.masters	= omap3xxx_l4_per_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_per_masters),
@@ -143,7 +143,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_masters[] = {
 
 /* L4 WKUP */
 static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
-	.name		= "l4_wkup_hwmod",
+	.name		= "l4_wkup",
 	.class		= &l4_hwmod_class,
 	.masters	= omap3xxx_l4_wkup_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_wkup_masters),
