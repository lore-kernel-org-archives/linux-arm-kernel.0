From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 15 Feb 2011 10:01:27 +0100
Subject: [PATCH for 2.6.38] ARM: S5PC110: fix regulator names
Message-ID: <1297760487-7930-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 1130e5b3ff4 regulators are exported to debugfs. The names
of the regulators that contains slash ('/') causes an ops during kernel
boot. This patch fixes this issue.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/mach-aquila.c |    6 +++---
 arch/arm/mach-s5pv210/mach-goni.c   |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 1236e19..557add4 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -149,7 +149,7 @@ static struct regulator_init_data aquila_ldo2_data = {
 
 static struct regulator_init_data aquila_ldo3_data = {
 	.constraints	= {
-		.name		= "VUSB/MIPI_1.1V",
+		.name		= "VUSB+MIPI_1.1V",
 		.min_uV		= 1100000,
 		.max_uV		= 1100000,
 		.apply_uV	= 1,
@@ -197,7 +197,7 @@ static struct regulator_init_data aquila_ldo7_data = {
 
 static struct regulator_init_data aquila_ldo8_data = {
 	.constraints	= {
-		.name		= "VUSB/VADC_3.3V",
+		.name		= "VUSB+VADC_3.3V",
 		.min_uV		= 3300000,
 		.max_uV		= 3300000,
 		.apply_uV	= 1,
@@ -207,7 +207,7 @@ static struct regulator_init_data aquila_ldo8_data = {
 
 static struct regulator_init_data aquila_ldo9_data = {
 	.constraints	= {
-		.name		= "VCC/VCAM_2.8V",
+		.name		= "VCC+VCAM_2.8V",
 		.min_uV		= 2800000,
 		.max_uV		= 2800000,
 		.apply_uV	= 1,
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 2beeb66..056f5c7 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -288,7 +288,7 @@ static struct regulator_init_data goni_ldo2_data = {
 
 static struct regulator_init_data goni_ldo3_data = {
 	.constraints	= {
-		.name		= "VUSB/MIPI_1.1V",
+		.name		= "VUSB+MIPI_1.1V",
 		.min_uV		= 1100000,
 		.max_uV		= 1100000,
 		.apply_uV	= 1,
@@ -337,7 +337,7 @@ static struct regulator_init_data goni_ldo7_data = {
 
 static struct regulator_init_data goni_ldo8_data = {
 	.constraints	= {
-		.name		= "VUSB/VADC_3.3V",
+		.name		= "VUSB+VADC_3.3V",
 		.min_uV		= 3300000,
 		.max_uV		= 3300000,
 		.apply_uV	= 1,
@@ -347,7 +347,7 @@ static struct regulator_init_data goni_ldo8_data = {
 
 static struct regulator_init_data goni_ldo9_data = {
 	.constraints	= {
-		.name		= "VCC/VCAM_2.8V",
+		.name		= "VCC+VCAM_2.8V",
 		.min_uV		= 2800000,
 		.max_uV		= 2800000,
 		.apply_uV	= 1,
-- 
1.7.1.569.g6f426
