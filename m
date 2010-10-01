From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:36 -0700
Subject: [PATCH 12/47] Davinci: tnetv107x: retain psc reg base after init
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-13-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

This is a bugfix for the original tnetv107x submission series.  The psc_regs
base array was being discarded post-init, and this was causing a crash during
post-init clock enable/disable.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/tnetv107x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/tnetv107x.c b/arch/arm/mach-davinci/tnetv107x.c
index 864e604..06d2ac9 100644
--- a/arch/arm/mach-davinci/tnetv107x.c
+++ b/arch/arm/mach-davinci/tnetv107x.c
@@ -104,7 +104,7 @@ static u32 pll_ext_freq[] = {
 };
 
 /* PSC control registers */
-static u32 psc_regs[] __initconst = { TNETV107X_PSC_BASE };
+static u32 psc_regs[] = { TNETV107X_PSC_BASE };
 
 /* Host map for interrupt controller */
 static u32 intc_host_map[] = { 0x01010000, 0x01010101, -1 };
-- 
1.7.2.1
