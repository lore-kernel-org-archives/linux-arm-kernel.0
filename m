From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 15:23:57 +0900
Subject: [PATCH 4/9] ARM: shmobile: armadillo800eva: Use gpio_set_value() to
 set GPIO value
In-Reply-To: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
References: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359613442-26038-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The GPIO is already configured as an output, there's no reason to use
gpio_direction_output() just to set the output value. Use
gpio_set_value() instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index efd6a36..f107e82 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -708,9 +708,9 @@ static int mt9t111_power(struct device *dev, int mode)
 		/* video1 (= CON1 camera) expect 24MHz */
 		clk_set_rate(mclk, clk_round_rate(mclk, 24000000));
 		clk_enable(mclk);
-		gpio_direction_output(GPIO_PORT158, 1);
+		gpio_set_value(GPIO_PORT158, 1);
 	} else {
-		gpio_direction_output(GPIO_PORT158, 0);
+		gpio_set_value(GPIO_PORT158, 0);
 		clk_disable(mclk);
 	}
 
-- 
1.7.10.4
