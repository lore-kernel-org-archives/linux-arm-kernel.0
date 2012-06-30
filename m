From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 30 Jun 2012 14:09:02 +0200
Subject: [PATCH 10/10] ARM: S3C24XX: Correct CAMIF interrupt definitions
In-Reply-To: <1341058142-30438-1-git-send-email-sylvester.nawrocki@gmail.com>
References: <1341058142-30438-1-git-send-email-sylvester.nawrocki@gmail.com>
Message-ID: <1341058142-30438-11-git-send-email-sylvester.nawrocki@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Properly define the CAMIF interrupt resources. This device have two
interrupts - corresponding to the "codec" and "preview" data paths.
IRQ_CAM is handled internally by the architecture and demultiplexed
to IRQ_S3C2440_CAM_C and IRQ_S3C2440_CAM_P - these interrupts only
should be handled in the driver.

Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 arch/arm/plat-samsung/devs.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 1d214cb..6303974 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -126,7 +126,8 @@ struct platform_device s3c_device_adc = {
 #ifdef CONFIG_CPU_S3C2440
 static struct resource s3c_camif_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C2440_PA_CAMIF, S3C2440_SZ_CAMIF),
-	[1] = DEFINE_RES_IRQ(IRQ_CAM),
+	[1] = DEFINE_RES_IRQ(IRQ_S3C2440_CAM_C),
+	[2] = DEFINE_RES_IRQ(IRQ_S3C2440_CAM_P),
 };
 
 struct platform_device s3c_device_camif = {
-- 
1.7.4.1
