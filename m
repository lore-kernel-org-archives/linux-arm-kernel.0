From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu,  1 Mar 2012 14:47:22 +0530
Subject: [PATCH 0/4] ARM: SAMSUNG: Add __init attribute to functions calling
 s3c_set_platdata
Message-ID: <1330593446-663-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function s3c_set_platdata is defined with __init attribute, hence the
functions calling s3c_set_platdata should also be defined with __init
attribute.

Even though all the modified functions are called from xxx_machine_init()
functions, it is still better to define each of them with __init attribute.

Tushar Behera (4):
  ARM: EXYNOS: Add __init attribute to nuri_camera_init()
  ARM: EXYNOS: Add __init attribute to universal_camera_init()
  ARM: SAMSUNG: Add __init attribute to samsung_bl_set()
  ARM: SAMSUNG: Add __init attribute to xxx_set_platdata() wrappers

 arch/arm/mach-exynos/mach-nuri.c           |    2 +-
 arch/arm/mach-exynos/mach-universal_c210.c |    2 +-
 arch/arm/plat-samsung/dev-backlight.c      |    2 +-
 arch/arm/plat-samsung/devs.c               |    4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
1.7.4.1
