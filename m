From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  2 May 2018 11:58:06 +0200
Subject: [PATCH 2/2] Revert "cpufreq: rcar: Add support for R8A7795 SoC"
In-Reply-To: <20180502095806.30341-1-horms+renesas@verge.net.au>
References: <20180502095806.30341-1-horms+renesas@verge.net.au>
Message-ID: <20180502095806.30341-3-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 034def597bb73cbf29ffade7d8aec8408af8c743.

This is no longer needed since the flowing commit and to the best
of my knowledge is not relied on by any upstream DTS:
edeec420de24 ("cpufreq: dt-platdev: Automatically create cpufreq device with OPP v2")

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 206ae7460f4a..c2165edadd41 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -66,7 +66,6 @@ static const struct of_device_id whitelist[] __initconst = {
 	{ .compatible = "renesas,r8a7792", },
 	{ .compatible = "renesas,r8a7793", },
 	{ .compatible = "renesas,r8a7794", },
-	{ .compatible = "renesas,r8a7795", },
 	{ .compatible = "renesas,sh73a0", },
 
 	{ .compatible = "rockchip,rk2928", },
-- 
2.11.0
