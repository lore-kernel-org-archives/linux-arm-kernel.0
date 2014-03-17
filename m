From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:16:14 +0000
Subject: [PATCH 32/44] ARM: l2c: add decode for L2C-220 cache ways
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLDy-0002e1-PF@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than assuming these are always 8-way, it can be decoded from the
auxillary register in the same manner as L2C-210.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index b932513366a3..f9829c7165e8 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -899,6 +899,7 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 		break;
 
 	case L2X0_CACHE_ID_PART_L210:
+	case L2X0_CACHE_ID_PART_L220:
 		ways = (aux >> 13) & 0xf;
 		break;
 
-- 
1.8.3.1
