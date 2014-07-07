From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:46 +0200
Subject: [PATCH v2 21/30] ARM: shmobile: r8a7740: add CMT1 clock support for DT
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-22-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be used when initialising CMT1 device using DT
until common clock framework support is added.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/mach-shmobile/clock-r8a7740.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index b4ecbd6..0794f04 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -603,6 +603,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("fck",	"sh-tmu.0",		&mstp_clks[MSTP125]),
 	CLKDEV_ICK_ID("fck",	"fff80000.timer",	&mstp_clks[MSTP125]),
 	CLKDEV_ICK_ID("fck",	"sh-cmt-48.1",		&mstp_clks[MSTP329]),
+	CLKDEV_ICK_ID("fck",	"e6138000.timer",	&mstp_clks[MSTP329]),
 	CLKDEV_ICK_ID("host",	"renesas_usbhs",	&mstp_clks[MSTP416]),
 	CLKDEV_ICK_ID("func",	"renesas_usbhs",	&mstp_clks[MSTP407]),
 	CLKDEV_ICK_ID("phy",	"renesas_usbhs",	&mstp_clks[MSTP406]),
-- 
2.0.0.rc2
