From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 6 Aug 2010 09:40:42 -0700
Subject: [PATCH] arm: uengine.c: remove C99 comments
Message-ID: <201008060940.42938.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Comments should be /* */ not //.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Jiri Kosina <trivial@kernel.org>

---

diff --git a/arch/arm/common/uengine.c b/arch/arm/common/uengine.c
index b520e56..bef408f 100644
--- a/arch/arm/common/uengine.c
+++ b/arch/arm/common/uengine.c
@@ -312,16 +312,16 @@ static void generate_ucode(u8 *ucode, u32 *gpr_a, u32 *gpr_b)
 		b1 = (gpr_a[i] >> 8) & 0xff;
 		b0 = gpr_a[i] & 0xff;
 
-		// immed[@ai, (b1 << 8) | b0]
-		// 11110000 0000VVVV VVVV11VV VVVVVV00 1IIIIIII
+		/* immed[@ai, (b1 << 8) | b0] */
+		/* 11110000 0000VVVV VVVV11VV VVVVVV00 1IIIIIII */
 		ucode[offset++] = 0xf0;
 		ucode[offset++] = (b1 >> 4);
 		ucode[offset++] = (b1 << 4) | 0x0c | (b0 >> 6);
 		ucode[offset++] = (b0 << 2);
 		ucode[offset++] = 0x80 | i;
 
-		// immed_w1[@ai, (b3 << 8) | b2]
-		// 11110100 0100VVVV VVVV11VV VVVVVV00 1IIIIIII
+		/* immed_w1[@ai, (b3 << 8) | b2] */
+		/* 11110100 0100VVVV VVVV11VV VVVVVV00 1IIIIIII */
 		ucode[offset++] = 0xf4;
 		ucode[offset++] = 0x40 | (b3 >> 4);
 		ucode[offset++] = (b3 << 4) | 0x0c | (b2 >> 6);
@@ -340,16 +340,16 @@ static void generate_ucode(u8 *ucode, u32 *gpr_a, u32 *gpr_b)
 		b1 = (gpr_b[i] >> 8) & 0xff;
 		b0 = gpr_b[i] & 0xff;
 
-		// immed[@bi, (b1 << 8) | b0]
-		// 11110000 0000VVVV VVVV001I IIIIII11 VVVVVVVV
+		/* immed[@bi, (b1 << 8) | b0] */
+		/* 11110000 0000VVVV VVVV001I IIIIII11 VVVVVVVV */
 		ucode[offset++] = 0xf0;
 		ucode[offset++] = (b1 >> 4);
 		ucode[offset++] = (b1 << 4) | 0x02 | (i >> 6);
 		ucode[offset++] = (i << 2) | 0x03;
 		ucode[offset++] = b0;
 
-		// immed_w1[@bi, (b3 << 8) | b2]
-		// 11110100 0100VVVV VVVV001I IIIIII11 VVVVVVVV
+		/* immed_w1[@bi, (b3 << 8) | b2] */
+		/* 11110100 0100VVVV VVVV001I IIIIII11 VVVVVVVV */
 		ucode[offset++] = 0xf4;
 		ucode[offset++] = 0x40 | (b3 >> 4);
 		ucode[offset++] = (b3 << 4) | 0x02 | (i >> 6);
@@ -357,7 +357,7 @@ static void generate_ucode(u8 *ucode, u32 *gpr_a, u32 *gpr_b)
 		ucode[offset++] = b2;
 	}
 
-	// ctx_arb[kill]
+	/* ctx_arb[kill] */
 	ucode[offset++] = 0xe0;
 	ucode[offset++] = 0x00;
 	ucode[offset++] = 0x01;
