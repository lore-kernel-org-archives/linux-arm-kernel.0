From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 17 Jun 2016 16:05:11 +0100
Subject: [PATCH 7/9] ARM: probes: fix warning on NULL/0 substitution
In-Reply-To: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1466175913-19067-8-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix warning from use of '0' as NULL pointer.

arch/arm/probes/kprobes/actions-common.c:131:42: warning: Using plain integer as NULL pointer

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/probes/kprobes/actions-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/probes/kprobes/actions-common.c b/arch/arm/probes/kprobes/actions-common.c
index bd20a71..60bf926 100644
--- a/arch/arm/probes/kprobes/actions-common.c
+++ b/arch/arm/probes/kprobes/actions-common.c
@@ -128,7 +128,7 @@ enum probes_insn __kprobes
 kprobe_decode_ldmstm(probes_opcode_t insn, struct arch_probes_insn *asi,
 		const struct decode_header *h)
 {
-	probes_insn_handler_t *handler = 0;
+	probes_insn_handler_t *handler = NULL;
 	unsigned reglist = insn & 0xffff;
 	int is_ldm = insn & 0x100000;
 	int rn = (insn >> 16) & 0xf;
-- 
2.8.1
