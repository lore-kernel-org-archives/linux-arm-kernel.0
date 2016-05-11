From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 14:02:14 +0200
Subject: [PATCH 18/18] clk: samsung: Fully constify mux parent names
In-Reply-To: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
References: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462968134-6085-18-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PNAME macro defines array of strings for names of mux parents.
Although the strings itself were const but pointers to them were not thus
this data resided in initdata. Make this an array of const pointers to
const strings and move to initconst section.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 61db98dd01a2..77d4657a95c5 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -261,7 +261,7 @@ struct samsung_gate_clock {
 #define GATE_DA(_id, dname, cname, pname, o, b, f, gf, a)	\
 	__GATE(_id, dname, cname, pname, o, b, f, gf, a)
 
-#define PNAME(x) static const char *x[] __initdata
+#define PNAME(x) static const char * const x[] __initconst
 
 /**
  * struct samsung_clk_reg_dump: register dump of clock controller registers.
-- 
1.9.1
