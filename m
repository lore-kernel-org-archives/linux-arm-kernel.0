From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Tue, 7 Aug 2018 18:59:57 -0500
Subject: [PATCH] arm64: alternative: Use true and false for boolean values
Message-ID: <20180807235726.GA6756@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return statements in functions returning bool should use true or false
instead of an integer value. This code was detected with the help of
Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/arm64/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 36fb069..b5d6039 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -47,11 +47,11 @@ static bool branch_insn_requires_update(struct alt_instr *alt, unsigned long pc)
 	unsigned long replptr;
 
 	if (kernel_text_address(pc))
-		return 1;
+		return true;
 
 	replptr = (unsigned long)ALT_REPL_PTR(alt);
 	if (pc >= replptr && pc <= (replptr + alt->alt_len))
-		return 0;
+		return false;
 
 	/*
 	 * Branching into *another* alternate sequence is doomed, and
-- 
2.7.4
