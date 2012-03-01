From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu,  1 Mar 2012 14:47:23 +0530
Subject: [PATCH 1/4] ARM: EXYNOS: Add __init attribute to nuri_camera_init()
In-Reply-To: <1330593446-663-1-git-send-email-tushar.behera@linaro.org>
References: <1330593446-663-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1330593446-663-2-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c_set_platdata() is defined with __init attribute, hence all functions
referencing this function should also be defined with __init attribute.

nuri_camera_init() is referenced only in '__init nuri_machine_init()', thus
this change won't put any additional constraint on the usage of
nuri_camera_init().

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-exynos/mach-nuri.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index a6b9162..7dc5c99 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -1255,7 +1255,7 @@ static struct gpio nuri_camera_gpios[] = {
 	{ GPIO_CAM_MEGA_RST,	GPIOF_OUT_INIT_LOW, "CAM_8M_NRST" },
 };
 
-static void nuri_camera_init(void)
+static void __init nuri_camera_init(void)
 {
 	s3c_set_platdata(&mipi_csis_platdata, sizeof(mipi_csis_platdata),
 			 &s5p_device_mipi_csis0);
-- 
1.7.4.1
