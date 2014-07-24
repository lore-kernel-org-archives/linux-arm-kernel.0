From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 24 Jul 2014 10:57:39 +0900
Subject: [PATCH 2/5] ARM: shmobile: r8a7740: add TMU clock support for DT
In-Reply-To: <cover.1406164563.git.horms+renesas@verge.net.au>
References: <cover.1406164563.git.horms+renesas@verge.net.au>
Message-ID: <ef9cb75ca70c8d31b2493d1fd6cbf8b3dd1dec95.1406164563.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be used when initialising TMU devices using DT
until common clock framework support is added.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7740.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 68592b7..3f34b3f 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -598,7 +598,9 @@ static struct clk_lookup lookups[] = {
 
 	/* ICK */
 	CLKDEV_ICK_ID("fck",	"sh-tmu.1",		&mstp_clks[MSTP111]),
+	CLKDEV_ICK_ID("fck",	"fff90000.timer",	&mstp_clks[MSTP111]),
 	CLKDEV_ICK_ID("fck",	"sh-tmu.0",		&mstp_clks[MSTP125]),
+	CLKDEV_ICK_ID("fck",	"fff80000.timer",	&mstp_clks[MSTP125]),
 	CLKDEV_ICK_ID("fck",	"sh-cmt-48.1",		&mstp_clks[MSTP329]),
 	CLKDEV_ICK_ID("host",	"renesas_usbhs",	&mstp_clks[MSTP416]),
 	CLKDEV_ICK_ID("func",	"renesas_usbhs",	&mstp_clks[MSTP407]),
-- 
2.0.1
