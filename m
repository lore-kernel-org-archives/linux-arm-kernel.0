From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 1 Sep 2013 03:18:09 +0400
Subject: [PATCH 2/4] ARM: shmobile: r8a7778: add Ether clock for DT case
In-Reply-To: <201309010311.05466.sergei.shtylyov@cogentembedded.com>
References: <201309010311.05466.sergei.shtylyov@cogentembedded.com>
Message-ID: <201309010318.10337.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add extra Ether clock lookup entry in the device tree case.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-shmobile/clock-r8a7778.c |    1 +
 1 file changed, 1 insertion(+)

Index: renesas/arch/arm/mach-shmobile/clock-r8a7778.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/clock-r8a7778.c
+++ renesas/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -146,6 +146,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
 	CLKDEV_DEV_ID("r8a777x-ether", &mstp_clks[MSTP114]), /* Ether */
+	CLKDEV_DEV_ID("fde00000.ethernet", &mstp_clks[MSTP114]), /* Ether w/DT */
 	CLKDEV_DEV_ID("ehci-platform", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
 	CLKDEV_DEV_ID("ohci-platform", &mstp_clks[MSTP100]), /* USB OHCI port0/1 */
 	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP030]), /* I2C0 */
