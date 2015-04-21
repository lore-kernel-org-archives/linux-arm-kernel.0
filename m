From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 21 Apr 2015 12:59:42 +0200
Subject: [PATCH v2 1/2] ARM: use ENDPROC() to annotate all v7 asm setup
 functions
In-Reply-To: <1429613983-22739-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1429613983-22739-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1429613983-22739-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This declares all v7 setup functions as functions using ENDPROC() so
that references to it will include the Thumb bit if the function was
emitted in Thumb mode. This ensures that these function are always called
in the correct mode.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/mm/proc-v7.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 3d1054f11a8a..f85993faeb05 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -278,6 +278,14 @@ __v7_ca17mp_setup:
 	mcreq	p15, 0, r0, c1, c0, 1
 #endif
 	b	__v7_setup
+ENDPROC(__v7_ca5mp_setup)
+ENDPROC(__v7_ca9mp_setup)
+ENDPROC(__v7_cr7mp_setup)
+ENDPROC(__v7_ca7mp_setup)
+ENDPROC(__v7_ca12mp_setup)
+ENDPROC(__v7_ca15mp_setup)
+ENDPROC(__v7_b15mp_setup)
+ENDPROC(__v7_ca17mp_setup)
 
 __v7_pj4b_setup:
 #ifdef CONFIG_CPU_PJ4B
@@ -457,6 +465,7 @@ __v7_setup:
  THUMB(	orr	r0, r0, #1 << 30	)	@ Thumb exceptions
 	ret	lr				@ return to head.S:__ret
 ENDPROC(__v7_setup)
+ENDPROC(__v7_pj4b_setup)
 
 	.align	2
 __v7_setup_stack:
-- 
1.8.3.2
