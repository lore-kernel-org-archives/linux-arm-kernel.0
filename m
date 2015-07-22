From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 22 Jul 2015 12:21:05 +0100
Subject: [PATCH v3 5/5] arm64: alternative: Remove alternative_insn macro
In-Reply-To: <1437564065-4356-1-git-send-email-daniel.thompson@linaro.org>
References: <1436536130-31438-1-git-send-email-daniel.thompson@linaro.org>
 <1437564065-4356-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1437564065-4356-6-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This macro has been superceded by the alterntive_if_not/else/endif
macro family and is no longer used anywhere in the kerne. Remove it.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/include/asm/alternative.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index e86681ad0931..81c7369eb358 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -65,18 +65,6 @@ void free_alternatives_memory(void);
 	.byte \alt_len
 .endm
 
-.macro alternative_insn insn1 insn2 cap
-661:	\insn1
-662:	.pushsection .altinstructions, "a"
-	altinstruction_entry 661b, 663f, \cap, 662b-661b, 664f-663f
-	.popsection
-	.pushsection .altinstr_replacement, "ax"
-663:	\insn2
-664:	.popsection
-	.org	. - (664b-663b) + (662b-661b)
-	.org	. - (662b-661b) + (664b-663b)
-.endm
-
 /*
  * Begin an alternative code sequence.
  *
-- 
2.4.3
