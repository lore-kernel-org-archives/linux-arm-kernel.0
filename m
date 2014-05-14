From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 May 2014 17:50:41 +0200
Subject: [RFC PATCHv1 7/7] ARM: mvebu: I/O coherency no longer needs SMP on
 375 and 38x
In-Reply-To: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400082641-23871-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index d5a975b..8f3f006 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -322,16 +322,9 @@ static int coherency_type(void)
 	if (np) {
 		int type = (int) match->data;
 
-		/* Armada 370/XP coherency works in both UP and SMP */
-		if (type == COHERENCY_FABRIC_TYPE_ARMADA_370_XP)
-			return type;
-
-		/* Armada 375 coherency works only on SMP */
-		else if (type == COHERENCY_FABRIC_TYPE_ARMADA_375 && is_smp())
-			return type;
-
-		/* Armada 380 coherency works only on SMP */
-		else if (type == COHERENCY_FABRIC_TYPE_ARMADA_380 && is_smp())
+		if (type == COHERENCY_FABRIC_TYPE_ARMADA_370_XP ||
+		    type == COHERENCY_FABRIC_TYPE_ARMADA_375    ||
+		    type == COHERENCY_FABRIC_TYPE_ARMADA_380)
 			return type;
 	}
 
-- 
1.9.3
