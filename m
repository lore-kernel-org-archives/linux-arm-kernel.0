From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:29 +0200
Subject: [PATCH v2 04/30] ARM: shmobile: r8a7778: add TMU clock support for DT
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be used when initialising TMU devices using DT
until common clock framework support is added.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* Added ack from Laurent Pinchart
---
 arch/arm/mach-shmobile/clock-r8a7778.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index 9557907..67980a0 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -244,7 +244,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("src.7", "rcar_sound", &mstp_clks[MSTP524]),
 	CLKDEV_ICK_ID("src.8", "rcar_sound", &mstp_clks[MSTP523]),
 	CLKDEV_ICK_ID("fck", "sh-tmu.0", &mstp_clks[MSTP016]),
+	CLKDEV_ICK_ID("fck", "ffd80000.timer", &mstp_clks[MSTP016]),
 	CLKDEV_ICK_ID("fck", "sh-tmu.1", &mstp_clks[MSTP015]),
+	CLKDEV_ICK_ID("fck", "ffd81000.timer", &mstp_clks[MSTP015]),
 };
 
 void __init r8a7778_clock_init(void)
-- 
2.0.0.rc2
