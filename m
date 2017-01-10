From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Jan 2017 11:09:31 +0100
Subject: [PATCH] ARM: defconfig: include QCOM_EBI2 in multi_v7
Message-ID: <20170110100931.15791-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Qualcomm External Bus Interface 2 to the multi_v7
defconfig: it is hard for users to realize that this is a
required driver for getting things like ethernet, and a necessary
prerequisite to get the external bus discoverable on the
MSM8660/APQ8060 machines.

As regular users will likely want to have some ethernet and
other functionality up quickly, it makes sense to add this to
the multi_v7 defconfig.

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please just apply this wherever ARM multi_v7
defconfigs go if you're OK with it.
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b01a43851294..267d0703caae 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -192,6 +192,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_OMAP_OCP2SCP=y
+CONFIG_QCOM_EBI2=y
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_SUNXI_RSB=m
 CONFIG_MTD=y
-- 
2.9.3
