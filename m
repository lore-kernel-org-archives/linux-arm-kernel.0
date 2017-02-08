From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Wed,  8 Feb 2017 23:09:31 +0100 (CET)
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: Switch AXP20x driver from module
 to built-in
In-Reply-To: <937914a68e4e7d6db2d12540cc6253b200978e2d.1486590875.git.rask@formelder.dk>
References: <937914a68e4e7d6db2d12540cc6253b200978e2d.1486590875.git.rask@formelder.dk>
Message-ID: <49ad3e66452bd78da7b9e581129f76633c56e609.1486590875.git.rask@formelder.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP20X regulator support is currently built as a module, which means
it's not available until the root fs has been mounted, but the boot loader
might not have enabled the required regulators, so build their drivers
into the kernel.

Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
---
This patch will have no effect if patch 2/4 is not applied. It will also
not apply cleanly without patch 3/4.

 arch/arm/configs/multi_v7_defconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5868186..cc071a0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -482,8 +482,8 @@ CONFIG_MFD_ATMEL_HLCDC=m
 CONFIG_MFD_BCM590XX=y
 CONFIG_MFD_AC100=y
 CONFIG_MFD_AXP20X=y
-CONFIG_MFD_AXP20X_I2C=m
-CONFIG_MFD_AXP20X_RSB=m
+CONFIG_MFD_AXP20X_I2C=y
+CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_CROS_EC=m
 CONFIG_MFD_CROS_EC_I2C=m
 CONFIG_MFD_CROS_EC_SPI=m
@@ -512,7 +512,7 @@ CONFIG_REGULATOR_ACT8865=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_AS3711=y
 CONFIG_REGULATOR_AS3722=y
-CONFIG_REGULATOR_AXP20X=m
+CONFIG_REGULATOR_AXP20X=y
 CONFIG_REGULATOR_BCM590XX=y
 CONFIG_REGULATOR_DA9210=y
 CONFIG_REGULATOR_FAN53555=y
-- 
2.10.2
