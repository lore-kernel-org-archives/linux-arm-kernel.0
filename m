From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 15 May 2013 10:51:27 +0100
Subject: [PATCH 04/39] ARM: ux500: Stop passing UART's platform data for
 Device Tree boots
In-Reply-To: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1368611522-9984-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was required to pass DMA channel configuration information to the
UART driver before the new DMA API was in place. Now that it is, and
is fully compatible with Device Tree we can stop doing that.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 38ebf2b..9b26fe2 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -230,9 +230,9 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	/* Requires call-back bindings. */
 	OF_DEV_AUXDATA("arm,cortex-a9-pmu", 0, "arm-pmu", &db8500_pmu_platdata),
 	/* Requires DMA bindings. */
-	OF_DEV_AUXDATA("arm,pl011", 0x80120000, "uart0", &uart0_plat),
-	OF_DEV_AUXDATA("arm,pl011", 0x80121000, "uart1", &uart1_plat),
-	OF_DEV_AUXDATA("arm,pl011", 0x80007000, "uart2", &uart2_plat),
+	OF_DEV_AUXDATA("arm,pl011", 0x80120000, "uart0", NULL),
+	OF_DEV_AUXDATA("arm,pl011", 0x80121000, "uart1", NULL),
+	OF_DEV_AUXDATA("arm,pl011", 0x80007000, "uart2", NULL),
 	OF_DEV_AUXDATA("arm,pl022", 0x80002000, "ssp0",  &ssp0_plat),
 	OF_DEV_AUXDATA("arm,pl18x", 0x80126000, "sdi0",  &mop500_sdi0_data),
 	OF_DEV_AUXDATA("arm,pl18x", 0x80118000, "sdi1",  &mop500_sdi1_data),
-- 
1.7.10.4
