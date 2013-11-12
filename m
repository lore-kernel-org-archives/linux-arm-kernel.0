From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 12 Nov 2013 20:39:12 -0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_HIGHMEM
Message-ID: <1384295952-10619-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Booting a mx6q wandboard with 2GB of RAM we see the following on boot:

Booting Linux on physical CPU 0x0                                               
Linux version 3.12.0-next-20131112+ (fabio at fabio-Latitude-E6410) (gcc version 43
CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c53c7d                
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache        
Machine model: Wandboard i.MX6 Quad Board                                       
Truncating RAM at 10000000-8fffffff to -7f7fffff (vmalloc region overlap)
...

Select CONFIG_HIGHMEM to avoid the vmalloc region overlap.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index c814e0e..f1c9bfa 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -42,6 +42,7 @@ CONFIG_VMSPLIT_2G=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
+CONFIG_HIGHMEM=y
 CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
 CONFIG_VFP=y
 CONFIG_NEON=y
-- 
1.8.1.2
