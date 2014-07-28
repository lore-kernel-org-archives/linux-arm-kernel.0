From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 28 Jul 2014 20:51:21 +0800
Subject: [PATCH v5 6/8] ARM: config: enable ARCH_HIX5HD2
In-Reply-To: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
References: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1406551883-26154-7-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since both ARCH_HI3xxx and ARCH_HIX5HD2 are based on Cortex A9 & they're
using similiar kernel features, make them share the hi3xxx_config.

And add it into multi_v7_defconfig too.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/configs/hi3xxx_defconfig   | 2 ++
 arch/arm/configs/multi_v7_defconfig | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/configs/hi3xxx_defconfig b/arch/arm/configs/hi3xxx_defconfig
index f186bdf..9630687 100644
--- a/arch/arm/configs/hi3xxx_defconfig
+++ b/arch/arm/configs/hi3xxx_defconfig
@@ -3,7 +3,9 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_RD_LZMA=y
+CONFIG_ARCH_HISI=y
 CONFIG_ARCH_HI3xxx=y
+CONFIG_ARCH_HIX5HD2=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e2d6204..d34ab30 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -25,6 +25,7 @@ CONFIG_MACH_BERLIN_BG2CD=y
 CONFIG_MACH_BERLIN_BG2Q=y
 CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_HI3xxx=y
+CONFIG_ARCH_HIX5HD2=y
 CONFIG_ARCH_KEYSTONE=y
 CONFIG_ARCH_MXC=y
 CONFIG_MACH_IMX51_DT=y
-- 
1.9.1
