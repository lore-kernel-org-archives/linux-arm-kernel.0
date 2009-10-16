From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:10 -0700
Subject: [PATCH 06/46] davinci: Add DA830/OMAP-L137 EVM specific pinmux
	setting for McASP1
In-Reply-To: <1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark A. Greer <mgreer@mvista.com>

The DA830/OMAP-L137 EVM cannot use the default pinmux setup for McASP1
so put the correct settings in the board file for that platform.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da830-evm.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 22d9fe4..39711c1 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -22,6 +22,7 @@
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/cp_intc.h>
+#include <mach/mux.h>
 #include <mach/da8xx.h>
 #include <mach/asp.h>
 
@@ -55,6 +56,14 @@ static struct davinci_uart_config da830_evm_uart_config __initdata = {
 	.enabled_uarts = 0x7,
 };
 
+static const short da830_evm_mcasp1_pins[] = {
+	DA830_AHCLKX1, DA830_ACLKX1, DA830_AFSX1, DA830_AHCLKR1, DA830_AFSR1,
+	DA830_AMUTE1, DA830_AXR1_0, DA830_AXR1_1, DA830_AXR1_2, DA830_AXR1_5,
+	DA830_ACLKR1, DA830_AXR1_6, DA830_AXR1_7, DA830_AXR1_8, DA830_AXR1_10,
+	DA830_AXR1_11,
+	-1
+};
+
 static u8 da830_iis_serializer_direction[] = {
 	RX_MODE,	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,
 	INACTIVE_MODE,	TX_MODE,	INACTIVE_MODE,	INACTIVE_MODE,
@@ -117,7 +126,7 @@ static __init void da830_evm_init(void)
 	i2c_register_board_info(1, da830_evm_i2c_devices,
 			ARRAY_SIZE(da830_evm_i2c_devices));
 
-	ret = da8xx_pinmux_setup(da830_mcasp1_pins);
+	ret = da8xx_pinmux_setup(da830_evm_mcasp1_pins);
 	if (ret)
 		pr_warning("da830_evm_init: mcasp1 mux setup failed: %d\n",
 				ret);
-- 
1.6.4.3
