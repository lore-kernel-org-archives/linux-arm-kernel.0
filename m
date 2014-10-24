From: kuninori.morimoto.gx@gmail.com (Kuninori Morimoto)
Date: Thu, 23 Oct 2014 18:17:35 -0700 (PDT)
Subject: [PATCH][resend] of: Add vendor 2nd prefix for Asahi Kasei Corp
Message-ID: <87siiep8pe.wl%kuninori.morimoto.gx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current vendor-prefixes.txt already has
"ak" prefix for Asahi Kasei Corp by
ae8c4209af2cec065fef15d200a42a04130799f7
(of: Add vendor prefix for Asahi Kasei Corp.)

It went through the appropriate review process,
and is already in use.
But, almost all Asahi Kasei chip driver is
using "asahi-kasei" prefix today.

Due to ABIness, this patch adds
"asahi-kasei" to vendor-prefixes.txt.
checkpatch.pl will report WARNING without this patch.
(DT compatible string vendor "asahi-kasei" appears un-documented)

OTOH, Asahi Kasei is usually referred to as "AKM",
but this patch doesn't care about it.
Because no DT is using that today.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index abc3080..7e4bb83 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -17,6 +17,7 @@ amstaos	AMS-Taos Inc.
 apm	Applied Micro Circuits Corporation (APM)
 arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
+asahi-kasei	Asahi Kasei Corp.
 atmel	Atmel Corporation
 auo	AU Optronics Corporation
 avago	Avago Technologies
-- 
1.7.9.5
