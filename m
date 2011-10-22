From: paul.s.schilling@gmail.com (Paul Schilling)
Date: Fri, 21 Oct 2011 23:21:41 -0500
Subject: [PATCH 06/14] ARM : SAMSUNG : S3C2416 Added io mapping for Static
	memory controller.
In-Reply-To: <static_memory>
References: <static_memory>
Message-ID: <1319257301-5040-1-git-send-email-paul.s.schilling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added MMU access to the Static Memory Controller.

Signed-off-by: Paul Schilling <paul.s.schilling@gmail.com>
---
 arch/arm/mach-s3c2416/s3c2416.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-s3c2416/s3c2416.c
index 494ce91..823a034 100644
--- a/arch/arm/mach-s3c2416/s3c2416.c
+++ b/arch/arm/mach-s3c2416/s3c2416.c
@@ -65,6 +65,18 @@ static struct map_desc s3c2416_iodesc[] __initdata = {
 	IODESC_ENT(WATCHDOG),
 	IODESC_ENT(CLKPWR),
 	IODESC_ENT(TIMER),
+	{
+		.virtual	= (u32)S3C2412_VA_SSMC,
+		.pfn		= __phys_to_pfn(S3C2412_PA_SSMC),
+		.length		= SZ_1M,
+		.type		= MT_DEVICE,
+	},
+	/*{
+		.virtual	= (u32)S3C2412_VA_EBI,
+		.pfn		= __phys_to_pfn(S3C2412_PA_EBI),
+		.length		= SZ_1M,
+		.type		= MT_DEVICE,
+	},*/
 };
 
 struct sysdev_class s3c2416_sysclass = {
-- 
1.7.6.4
