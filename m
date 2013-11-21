From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 21 Nov 2013 17:30:51 +0200
Subject: [PATCH] clk: keystone: gate: don't use reserved bits
Message-ID: <1385047851-14407-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to TRM http://www.ti.com/lit/ug/sprugv4b/sprugv4b.pdf
the Power Domain Status Register (PDSTAT) has 0-1 bits for power
domain status, but PDSTAT_STATE_MASK is defined with 0x1F. In that
case we operate with reserved bits. So correct PDSTAT_STATE_MASK
to be 0x03.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 drivers/clk/keystone/gate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/keystone/gate.c b/drivers/clk/keystone/gate.c
index 1f333bc..995ae80 100644
--- a/drivers/clk/keystone/gate.c
+++ b/drivers/clk/keystone/gate.c
@@ -35,7 +35,7 @@
 
 #define MDSTAT_STATE_MASK	0x3f
 #define MDSTAT_MCKOUT		BIT(12)
-#define PDSTAT_STATE_MASK	0x1f
+#define PDSTAT_STATE_MASK	0x03
 #define MDCTL_FORCE		BIT(31)
 #define MDCTL_LRESET		BIT(8)
 #define PDCTL_NEXT		BIT(0)
-- 
1.7.9.5
