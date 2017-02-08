From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Wed,  8 Feb 2017 23:08:00 +0100 (CET)
Subject: [PATCH 2/4] ARM: multi_v7_defconfig: Switch sunxi RSB driver from
 module to built-in
In-Reply-To: <937914a68e4e7d6db2d12540cc6253b200978e2d.1486590875.git.rask@formelder.dk>
References: <937914a68e4e7d6db2d12540cc6253b200978e2d.1486590875.git.rask@formelder.dk>
Message-ID: <870393c080135a968b9c0d9e78e3009fb32593f3.1486590875.git.rask@formelder.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sunxi RSB bus is used for peripherals like voltage regulators and
real-time clocks which should be available early in the boot process.
As a module, the driver will not be available until the root fs has been
mounted, so build the driver into the kernel.

Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 028d2b7..ec3a110 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -193,7 +193,7 @@ CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_OMAP_OCP2SCP=y
 CONFIG_SIMPLE_PM_BUS=y
-CONFIG_SUNXI_RSB=m
+CONFIG_SUNXI_RSB=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
-- 
2.10.2
