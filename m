From: mturquette@ti.com (Mike Turquette)
Date: Tue, 13 Dec 2011 20:11:56 -0800
Subject: [PATCH 5/7] omap: panda: use clk_prepare in ehci init
In-Reply-To: <1323835918-2371-1-git-send-email-mturquette@ti.com>
References: <1323835918-2371-1-git-send-email-mturquette@ti.com>
Message-ID: <1323835918-2371-6-git-send-email-mturquette@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index a8c2c42..3864d31 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -122,6 +122,7 @@ static void __init omap4_ehci_init(void)
 		return;
 	}
 	clk_set_rate(phy_ref_clk, 19200000);
+	clk_prepare(phy_ref_clk);
 	clk_enable(phy_ref_clk);
 
 	/* disable the power to the usb hub prior to init and reset phy+hub */
-- 
1.7.5.4
