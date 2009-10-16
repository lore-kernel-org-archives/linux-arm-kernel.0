From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:09 -0700
Subject: [PATCH 05/46] davinci: Change DA8xx/OMAP-L13x McASP registration
	routine name
In-Reply-To: <1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark A. Greer <mgreer@mvista.com>

For consistency with existing code, change the name of
da8xx_init_mcasp() to da8xx_register_mcasp().

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da830-evm.c    |    2 +-
 arch/arm/mach-davinci/board-da850-evm.c    |    2 +-
 arch/arm/mach-davinci/devices-da8xx.c      |    2 +-
 arch/arm/mach-davinci/include/mach/da8xx.h |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index bfbb639..22d9fe4 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -122,7 +122,7 @@ static __init void da830_evm_init(void)
 		pr_warning("da830_evm_init: mcasp1 mux setup failed: %d\n",
 				ret);
 
-	da8xx_init_mcasp(1, &da830_evm_snd_data);
+	da8xx_register_mcasp(1, &da830_evm_snd_data);
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index c759d72..fbc7aae 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -365,7 +365,7 @@ static __init void da850_evm_init(void)
 		pr_warning("da850_evm_init: mcasp mux setup failed: %d\n",
 				ret);
 
-	da8xx_init_mcasp(0, &da850_evm_snd_data);
+	da8xx_register_mcasp(0, &da850_evm_snd_data);
 
 	ret = da8xx_pinmux_setup(da850_lcdcntl_pins);
 	if (ret)
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 94ce7a1..a54aa4e 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -343,7 +343,7 @@ static struct platform_device da850_mcasp_device = {
 	.resource	= da850_mcasp_resources,
 };
 
-void __init da8xx_init_mcasp(int id, struct snd_platform_data *pdata)
+void __init da8xx_register_mcasp(int id, struct snd_platform_data *pdata)
 {
 	/* DA830/OMAP-L137 has 3 instances of McASP */
 	if (cpu_is_davinci_da830() && id == 1) {
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index d4095d0..7576e8c 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -74,7 +74,7 @@ int da8xx_register_watchdog(void);
 int da8xx_register_emac(void);
 int da8xx_register_lcdc(void);
 int da8xx_register_mmcsd0(struct davinci_mmc_config *config);
-void __init da8xx_init_mcasp(int id, struct snd_platform_data *pdata);
+void __init da8xx_register_mcasp(int id, struct snd_platform_data *pdata);
 
 extern struct platform_device da8xx_serial_device;
 extern struct emac_platform_data da8xx_emac_pdata;
-- 
1.6.4.3
