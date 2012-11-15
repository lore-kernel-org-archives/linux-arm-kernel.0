From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 15 Nov 2012 08:33:21 +0000
Subject: [PATCH 1/1] ARM: ux500: Describe UART platform registering issues
 more accurately
Message-ID: <1352968401-6092-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UARTs no longer require call-back information, since the reset
call-back was removed in 43b5f0d69291374f602ad8e1817f329573a59010.
The only AUXDATA dependencies remaining for UARTs are DMA settings.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 4a0c40a..d2076ce 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -262,11 +262,10 @@ static struct device * __init u8500_of_init_devices(void)
 static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	/* Requires call-back bindings. */
 	OF_DEV_AUXDATA("arm,cortex-a9-pmu", 0, "arm-pmu", &db8500_pmu_platdata),
-	/* Requires DMA and call-back bindings. */
+	/* Requires DMA bindings. */
 	OF_DEV_AUXDATA("arm,pl011", 0x80120000, "uart0", &uart0_plat),
 	OF_DEV_AUXDATA("arm,pl011", 0x80121000, "uart1", &uart1_plat),
 	OF_DEV_AUXDATA("arm,pl011", 0x80007000, "uart2", &uart2_plat),
-	/* Requires DMA bindings. */
 	OF_DEV_AUXDATA("arm,pl022", 0x80002000, "ssp0",  &ssp0_plat),
 	OF_DEV_AUXDATA("arm,pl18x", 0x80126000, "sdi0",  &mop500_sdi0_data),
 	OF_DEV_AUXDATA("arm,pl18x", 0x80118000, "sdi1",  &mop500_sdi1_data),
-- 
1.7.9.5
