From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 19 Dec 2017 11:22:44 -0800
Subject: [PATCH v2 6/9] soc: brcmstb: biuctrl: Wire-up new registers
In-Reply-To: <20171219192247.29799-1-f.fainelli@gmail.com>
References: <20171219192247.29799-1-f.fainelli@gmail.com>
Message-ID: <20171219192247.29799-7-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add definitions for B53 systems register: CPU_MCP_FLOW_REG and
CPU_WRITEBACK_CTRL_REG. These register will be saved and restored
accordingly.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index 16cbfc2e953a..d498f9db01ab 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -49,17 +49,23 @@ static inline void cbc_writel(u32 val, int reg)
 
 enum cpubiuctrl_regs {
 	CPU_CREDIT_REG = 0,
+	CPU_MCP_FLOW_REG,
+	CPU_WRITEBACK_CTRL_REG
 };
 
 static const int b15_cpubiuctrl_regs[] = {
 	[CPU_CREDIT_REG] = 0x184,
+	[CPU_MCP_FLOW_REG] = -1,
+	[CPU_WRITEBACK_CTRL_REG] = -1,
 };
 
 static const int b53_cpubiuctrl_regs[] = {
 	[CPU_CREDIT_REG] = 0x0b0,
+	[CPU_MCP_FLOW_REG] = 0x0b4,
+	[CPU_WRITEBACK_CTRL_REG] = 0x22c,
 };
 
-#define NUM_CPU_BIUCTRL_REGS	1
+#define NUM_CPU_BIUCTRL_REGS	3
 
 static int __init mcp_write_pairing_set(void)
 {
-- 
2.9.3
