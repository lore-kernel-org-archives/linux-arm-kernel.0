From: per.xx.fransson@stericsson.com (Per Fransson)
Date: Mon, 1 Nov 2010 19:32:54 +0100
Subject: [RFC 1/2] Selective MMU identity mapping for kexec
In-Reply-To: <1288636375-22805-1-git-send-email-per.xx.fransson@stericsson.com>
References: <1288636375-22805-1-git-send-email-per.xx.fransson@stericsson.com>
Message-ID: <1288636375-22805-2-git-send-email-per.xx.fransson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
---
 arch/arm/mm/proc-v7.S |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 2b5b20b..b249143 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -61,6 +61,9 @@ ENDPROC(cpu_v7_proc_fin)
  */
 	.align	5
 ENTRY(cpu_v7_reset)
+	mrc	p15, 0, ip, c1, c0, 0		@ ctrl register
+	bic	ip, ip, #0x0001			@ ...............m
+	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 	mov	pc, r0
 ENDPROC(cpu_v7_reset)
 
-- 
1.7.2.2
