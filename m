From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 20:03:48 +0100
Subject: [PATCH 4/5] mvebu: make mvebu_armada375_smp_wa_init() static
In-Reply-To: <1465326229-24787-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465326229-24787-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1465326229-24787-5-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvebu_armada375_smp_wa_init() is not exported or declared
anywhere, so make it static to fix the following warning:

arch/arm/mach-mvebu/system-controller.c:130:6: warning: symbol 'mvebu_armada375_smp_wa_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-mvebu/system-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index c6c132a..76cbc82 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -127,7 +127,7 @@ int mvebu_system_controller_get_soc_id(u32 *dev, u32 *rev)
 }
 
 #if defined(CONFIG_SMP) && defined(CONFIG_MACH_MVEBU_V7)
-void mvebu_armada375_smp_wa_init(void)
+static void mvebu_armada375_smp_wa_init(void)
 {
 	u32 dev, rev;
 	phys_addr_t resume_addr_reg;
-- 
2.8.1
