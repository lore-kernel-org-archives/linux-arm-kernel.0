From: amonakov@ispras.ru (Alexander Monakov)
Date: Sun, 18 Mar 2018 20:11:49 +0300 (MSK)
Subject: [PATCHv2 1/8] ARM: berlin: extend BG2CD Kconfig entry
In-Reply-To: <20180314135832.0ebdeb66@xhacker.debian>
References: <20180311160008.22928-1-amonakov@ispras.ru>
 <20180311160008.22928-2-amonakov@ispras.ru>
 <20180314135832.0ebdeb66@xhacker.debian>
Message-ID: <alpine.LNX.2.20.13.1803182010510.26526@monopod.intra.ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BG2CD SoC uses r3p0 Cortex-A9 MPCore single-CPU cluster. Autoselect
pertinent errata, the SCU and the global timer, and allow use of the
local timer on uniprocessor kernels.

PL310 L2 cache controller has revision r3p2; no errata to select.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
v2: address feedback from Jisheng:
* do not autoselect any PL310 errata

 arch/arm/mach-berlin/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
index 63ab1d368625..3d719cf645e3 100644
--- a/arch/arm/mach-berlin/Kconfig
+++ b/arch/arm/mach-berlin/Kconfig
@@ -23,8 +23,12 @@ config MACH_BERLIN_BG2
 
 config MACH_BERLIN_BG2CD
 	bool "Marvell Armada 1500-mini (BG2CD)"
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_775420
+	select ARM_GLOBAL_TIMER
 	select CACHE_L2X0
-	select HAVE_ARM_TWD if SMP
+	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD
 	select PINCTRL_BERLIN_BG2CD
 
 config MACH_BERLIN_BG2Q
-- 
2.11.0
