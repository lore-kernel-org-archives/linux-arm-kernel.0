From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:43 +0200
Subject: [PATCH v2 18/30] ARM: shmobile: r8a7740: add TMU clock support for DT
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-19-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be used when initialising TMU devices using DT
until common clock framework support is added.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/mach-shmobile/clock-r8a7740.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index a60c324..b4ecbd6 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -599,7 +599,9 @@ static struct clk_lookup lookups[] = {
 
 	/* ICK */
 	CLKDEV_ICK_ID("fck",	"sh-tmu.1",		&mstp_clks[MSTP111]),
+	CLKDEV_ICK_ID("fck",	"fff90000.timer",	&mstp_clks[MSTP111]),
 	CLKDEV_ICK_ID("fck",	"sh-tmu.0",		&mstp_clks[MSTP125]),
+	CLKDEV_ICK_ID("fck",	"fff80000.timer",	&mstp_clks[MSTP125]),
 	CLKDEV_ICK_ID("fck",	"sh-cmt-48.1",		&mstp_clks[MSTP329]),
 	CLKDEV_ICK_ID("host",	"renesas_usbhs",	&mstp_clks[MSTP416]),
 	CLKDEV_ICK_ID("func",	"renesas_usbhs",	&mstp_clks[MSTP407]),
-- 
2.0.0.rc2
