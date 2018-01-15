From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Mon, 15 Jan 2018 15:23:50 +0000
Subject: [PATCH 3/3] arm64: fix comment above tcr_compute_pa_size
In-Reply-To: <1516029830-12326-1-git-send-email-kristina.martsenko@arm.com>
References: <1516029830-12326-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <1516029830-12326-4-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'pos' argument is used to select where in TCR to write the value:
the IPS or PS bitfield.

Fixes: 787fd1d019b2 ("arm64: limit PA size to supported range")
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/assembler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 215a49213507..b9f30ebc1820 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -352,7 +352,7 @@ alternative_endif
  * ID_AA64MMFR0_EL1.PARange value
  *
  *	tcr:		register with the TCR_ELx value to be updated
- *	pos:		PARange bitfield position
+ *	pos:		IPS or PS bitfield position
  *	tmp{0,1}:	temporary registers
  */
 	.macro	tcr_compute_pa_size, tcr, pos, tmp0, tmp1
-- 
2.1.4
