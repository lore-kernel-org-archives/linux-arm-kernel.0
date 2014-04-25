From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:42:57 +0100
Subject: [PATCH 135/222] ARM: imx: set IPU to be derived from the 540MHz PLL3
 PFD1 clock
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeWv-0007MH-2s@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the IPU muxer to derive the clock from the PLL3 FPD1 clock,
which increases its clock rate from 198MHz to 270MHz.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-imx/clk-imx6q.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index b0e7f9d2c245..f4d0b0e3e041 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -445,6 +445,10 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 		clk_set_parent(clk[ldb_di1_sel], clk[pll5_video_div]);
 	}
 
+	if (cpu_is_imx6dl()) {
+		clk_set_parent(clk[ipu1_sel], clk[pll3_pfd1_540m]);
+	}
+
 	/*
 	 * The gpmi needs 100MHz frequency in the EDO/Sync mode,
 	 * We can not get the 100MHz from the pll2_pfd0_352m.
-- 
1.8.3.1
