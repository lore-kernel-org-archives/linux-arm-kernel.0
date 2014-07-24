From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 24 Jul 2014 10:57:41 +0900
Subject: [PATCH 4/5] ARM: shmobile: r8a7740: add CMT1 clock support for DT
In-Reply-To: <cover.1406164563.git.horms+renesas@verge.net.au>
References: <cover.1406164563.git.horms+renesas@verge.net.au>
Message-ID: <2e11179da78a56c2a44fc3fe097f2af8dc18f9d6.1406164563.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be used when initialising CMT1 device using DT
until common clock framework support is added.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7740.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 3f34b3f..2ffb560 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -602,6 +602,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("fck",	"sh-tmu.0",		&mstp_clks[MSTP125]),
 	CLKDEV_ICK_ID("fck",	"fff80000.timer",	&mstp_clks[MSTP125]),
 	CLKDEV_ICK_ID("fck",	"sh-cmt-48.1",		&mstp_clks[MSTP329]),
+	CLKDEV_ICK_ID("fck",	"e6138000.timer",	&mstp_clks[MSTP329]),
 	CLKDEV_ICK_ID("host",	"renesas_usbhs",	&mstp_clks[MSTP416]),
 	CLKDEV_ICK_ID("func",	"renesas_usbhs",	&mstp_clks[MSTP407]),
 	CLKDEV_ICK_ID("phy",	"renesas_usbhs",	&mstp_clks[MSTP406]),
-- 
2.0.1
