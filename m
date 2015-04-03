From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 03 Apr 2015 18:13:29 +0100
Subject: [PATCH 13/14] ASoC: migor: use clkdev_create()
In-Reply-To: <20150403171149.GC13898@n2100.arm.linux.org.uk>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
Message-ID: <E1Ye59t-0001Bl-8o@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clkdev_create() is a shorter way to write clkdev_alloc() followed by
clkdev_add().  Use this instead.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/sh/migor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/migor.c b/sound/soc/sh/migor.c
index 82f582344fe7..672bcd4c252b 100644
--- a/sound/soc/sh/migor.c
+++ b/sound/soc/sh/migor.c
@@ -162,12 +162,11 @@ static int __init migor_init(void)
 	if (ret < 0)
 		return ret;
 
-	siumckb_lookup = clkdev_alloc(&siumckb_clk, "siumckb_clk", NULL);
+	siumckb_lookup = clkdev_create(&siumckb_clk, "siumckb_clk", NULL);
 	if (!siumckb_lookup) {
 		ret = -ENOMEM;
 		goto eclkdevalloc;
 	}
-	clkdev_add(siumckb_lookup);
 
 	/* Port number used on this machine: port B */
 	migor_snd_device = platform_device_alloc("soc-audio", 1);
-- 
1.8.3.1
