From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 10 Dec 2016 15:47:34 +0200
Subject: [PATCH 3/7] ARM: s3c24xx: Constify few integer tables
In-Reply-To: <1481377658-22603-1-git-send-email-krzk@kernel.org>
References: <1481377658-22603-1-git-send-email-krzk@kernel.org>
Message-ID: <1481377658-22603-3-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These arrays are not modified so they can be made const.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/bast-irq.c         | 4 ++--
 arch/arm/mach-s3c24xx/iotiming-s3c2410.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/bast-irq.c b/arch/arm/mach-s3c24xx/bast-irq.c
index 2bb08961e934..ad8f4cd7c327 100644
--- a/arch/arm/mach-s3c24xx/bast-irq.c
+++ b/arch/arm/mach-s3c24xx/bast-irq.c
@@ -44,7 +44,7 @@
 /* table of ISA irq nos to the relevant mask... zero means
  * the irq is not implemented
 */
-static unsigned char bast_pc104_irqmasks[] = {
+static const unsigned char bast_pc104_irqmasks[] = {
 	0,   /* 0 */
 	0,   /* 1 */
 	0,   /* 2 */
@@ -63,7 +63,7 @@ static unsigned char bast_pc104_irqmasks[] = {
 	0,   /* 15 */
 };
 
-static unsigned char bast_pc104_irqs[] = { 3, 5, 7, 10 };
+static const unsigned char bast_pc104_irqs[] = { 3, 5, 7, 10 };
 
 static void
 bast_pc104_mask(struct irq_data *data)
diff --git a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
index 65e5f9cb650f..b7970f1fa3d5 100644
--- a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
@@ -249,7 +249,7 @@ static int s3c2410_calc_bank(struct s3c_cpufreq_config *cfg,
 	return 0;
 }
 
-static unsigned int tacc_tab[] = {
+static const unsigned int tacc_tab[] = {
 	[0]	= 1,
 	[1]	= 2,
 	[2]	= 3,
-- 
2.7.4
