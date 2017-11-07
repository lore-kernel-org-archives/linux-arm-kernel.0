From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue,  7 Nov 2017 11:24:04 +0900
Subject: [PATCH] arm64: make label allocation style consistent in tishift
Message-ID: <20171107022404.15937-1-Jason@zx2c4.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is entirely cosmetic, but somehow it was missed when sending
differing versions of this patch. This just makes the file a bit more
uniform.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
This has no functional changes, but it does make the file a bit more
uniform and nice, if that kind of thing is important to you.

 arch/arm64/lib/tishift.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/lib/tishift.S b/arch/arm64/lib/tishift.S
index 0179a43cc045..d3db9b2cd479 100644
--- a/arch/arm64/lib/tishift.S
+++ b/arch/arm64/lib/tishift.S
@@ -38,19 +38,19 @@ ENTRY(__ashlti3)
 ENDPROC(__ashlti3)
 
 ENTRY(__ashrti3)
-	cbz	x2, 3f
+	cbz	x2, 1f
 	mov	x3, #64
 	sub	x3, x3, x2
 	cmp	x3, #0
-	b.le	4f
+	b.le	2f
 	lsr	x0, x0, x2
 	lsl	x3, x1, x3
 	asr	x2, x1, x2
 	orr	x0, x0, x3
 	mov	x1, x2
-3:
+1:
 	ret
-4:
+2:
 	neg	w0, w3
 	asr	x2, x1, #63
 	asr	x0, x1, x0
-- 
2.15.0
