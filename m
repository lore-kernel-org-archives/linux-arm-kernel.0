From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:32:35 +0100
Subject: [PATCH 75/97] ARM: l2c: kill L2X0_AUX_CTRL_MASK before anyone else
 makes use of this
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerI3-0001Ym-6z@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

L2X0_AUX_CTRL_MASK is not useful for PL310s.  It would be better if
people thought about their value for this rather than cargo-cult
programming.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/hardware/cache-l2x0.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index b3ee122c6f24..84bbd31b8910 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -87,7 +87,6 @@
 #define L310_CACHE_ID_RTL_R3P2		0x08
 #define L310_CACHE_ID_RTL_R3P3		0x09
 
-#define L2X0_AUX_CTRL_MASK			0xc0000fff
 /* L2C auxiliary control register - bits common to L2C-210/220/310 */
 #define L2C_AUX_CTRL_WAY_SIZE_SHIFT		17
 #define L2C_AUX_CTRL_WAY_SIZE_MASK		(7 << 17)
-- 
1.8.3.1
