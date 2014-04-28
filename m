From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:29:26 +0100
Subject: [PATCH 38/97] ARM: l2c: add decode for L2C-220 cache ways
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerF0-0001Vu-12@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than assuming these are always 8-way, it can be decoded from the
auxillary register in the same manner as L2C-210.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index b4dd2f4b491b..69a18316b239 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -701,6 +701,7 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 		break;
 
 	case L2X0_CACHE_ID_PART_L210:
+	case L2X0_CACHE_ID_PART_L220:
 		ways = (aux >> 13) & 0xf;
 		break;
 
-- 
1.8.3.1
