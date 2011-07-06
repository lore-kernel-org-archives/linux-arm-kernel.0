From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 6 Jul 2011 11:31:24 +0530
Subject: [PATCH 5/5] davinci: da850 evm: register SATA device
In-Reply-To: <cover.1309927427.git.nsekhar@ti.com>
References: <cover.1309927427.git.nsekhar@ti.com>
Message-ID: <f4ad660e93a6b8f573e1f25b1e3717985d19ddca.1309927428.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the platform device for SATA interface
present on the DA850/OMAP-L138/AM18x EVM.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/board-da850-evm.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index a7b41bf..3d2c0d7 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1117,6 +1117,8 @@ static __init int da850_evm_init_cpufreq(void)
 static __init int da850_evm_init_cpufreq(void) { return 0; }
 #endif
 
+#define DA850EVM_SATA_REFCLKPN_RATE	(100 * 1000 * 1000)
+
 static __init void da850_evm_init(void)
 {
 	int ret;
@@ -1237,6 +1239,11 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warning("da850_evm_init: spi 1 registration failed: %d\n",
 				ret);
+
+	ret = da850_register_sata(DA850EVM_SATA_REFCLKPN_RATE);
+	if (ret)
+		pr_warning("da850_evm_init: sata registration failed: %d\n",
+				ret);
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
1.7.3.2
