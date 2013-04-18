From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Apr 2013 11:12:14 +0100
Subject: [PATCH 32/32] ARM: ux500: Move SDI (MMC) and UART devices under more
 descriptive heading
In-Reply-To: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1366279934-30761-33-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now DMA DT bindings exist and are in use by he MMC and UART drivers, it
should be possible to remove them from the auxdata structure. However,
after doing so the drivers fail. Something must be reliant on the dev
name applied by using auxdata; probably common clk.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 501281c..f56e2da0 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -236,15 +236,15 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	/* Requires call-back bindings. */
 	OF_DEV_AUXDATA("arm,cortex-a9-pmu", 0, "arm-pmu", &db8500_pmu_platdata),
 	/* Requires DMA bindings. */
+	OF_DEV_AUXDATA("arm,pl022", 0x80002000, "ssp0",  &ssp0_plat),
+	/* Requires clock name bindings. */
 	OF_DEV_AUXDATA("arm,pl011", 0x80120000, "uart0", NULL),
 	OF_DEV_AUXDATA("arm,pl011", 0x80121000, "uart1", NULL),
 	OF_DEV_AUXDATA("arm,pl011", 0x80007000, "uart2", NULL),
-	OF_DEV_AUXDATA("arm,pl022", 0x80002000, "ssp0",  &ssp0_plat),
 	OF_DEV_AUXDATA("arm,pl18x", 0x80126000, "sdi0",  NULL),
 	OF_DEV_AUXDATA("arm,pl18x", 0x80118000, "sdi1",  NULL),
 	OF_DEV_AUXDATA("arm,pl18x", 0x80005000, "sdi2",  NULL),
 	OF_DEV_AUXDATA("arm,pl18x", 0x80114000, "sdi4",  NULL),
-	/* Requires clock name bindings. */
 	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8012e000, "gpio.0", NULL),
 	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8012e080, "gpio.1", NULL),
 	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8000e000, "gpio.2", NULL),
-- 
1.7.10.4
