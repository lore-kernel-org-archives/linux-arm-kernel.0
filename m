From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Wed,  6 Oct 2010 01:09:58 +0200
Subject: [PATCH 1/2] ARM: S3C64XX: Add suspend support
In-Reply-To: <cover.1286319272.git.mcuelenaere@gmail.com>
References: <cover.1286319272.git.mcuelenaere@gmail.com>
Message-ID: <1fa4a7a39d9fd48b8329e1a1077a65adb96475b5.1286319272.git.mcuelenaere@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only missing thing for SoC-wide suspend support, is a call to s3c_pm_init,
so add that. This was tested on a S3C6410 SmartQ 7.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c64xx/pm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index 79412f7..db292c9 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -187,6 +187,9 @@ static int s3c64xx_pm_init(void)
 	pm_cpu_prep = s3c64xx_pm_prepare;
 	pm_cpu_sleep = s3c64xx_cpu_suspend;
 	pm_uart_udivslot = 1;
+
+	s3c_pm_init();
+
 	return 0;
 }
 
-- 
1.7.2.3
