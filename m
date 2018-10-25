From: nickhu@andestech.com (Nick Hu)
Date: Thu, 25 Oct 2018 10:24:14 +0800
Subject: [PATCH v4 1/4] nds32: Fix bug in bitfield.h
In-Reply-To: <cover.1540430861.git.nickhu@andestech.com>
References: <cover.1540430861.git.nickhu@andestech.com>
Message-ID: <1e30cef737d040ad4cae7e80737354d370ce938e.1540430862.git.nickhu@andestech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nickhu <nickhu@andestech.com>

There two bitfield bug for perfomance counter
in bitfield.h:

	PFM_CTL_offSEL1		21 --> 16
	PFM_CTL_offSEL2		27 --> 22

This commit fix it.

Signed-off-by: Nickhu <nickhu@andestech.com>
---
 arch/nds32/include/asm/bitfield.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/nds32/include/asm/bitfield.h b/arch/nds32/include/asm/bitfield.h
index 8e84fc385b94..19b2841219ad 100644
--- a/arch/nds32/include/asm/bitfield.h
+++ b/arch/nds32/include/asm/bitfield.h
@@ -692,8 +692,8 @@
 #define PFM_CTL_offKU1		13	/* Enable user mode event counting for PFMC1 */
 #define PFM_CTL_offKU2		14	/* Enable user mode event counting for PFMC2 */
 #define PFM_CTL_offSEL0		15	/* The event selection for PFMC0 */
-#define PFM_CTL_offSEL1		21	/* The event selection for PFMC1 */
-#define PFM_CTL_offSEL2		27	/* The event selection for PFMC2 */
+#define PFM_CTL_offSEL1		16	/* The event selection for PFMC1 */
+#define PFM_CTL_offSEL2		22	/* The event selection for PFMC2 */
 /* bit 28:31 reserved */
 
 #define PFM_CTL_mskEN0		( 0x01  << PFM_CTL_offEN0 )
-- 
2.17.0
