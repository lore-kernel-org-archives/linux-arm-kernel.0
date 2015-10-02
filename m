From: jonmason@broadcom.com (Jon Mason)
Date: Fri, 2 Oct 2015 18:57:38 -0400
Subject: [PATCH 03/10] clk: iproc: define Broadcom NSP iProc clock binding
In-Reply-To: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
References: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1443826665-17570-4-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the device tree bindings for Broadcom Northstar Plus
architecture based clock controller

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 .../bindings/clock/brcm,iproc-clocks.txt           | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt b/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
index da8d9bb..b3c3e9d 100644
--- a/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
@@ -130,3 +130,33 @@ These clock IDs are defined in:
     ch3_unused mipipll          4       BCM_CYGNUS_MIPIPLL_CH3_UNUSED
     ch4_unused mipipll          5       BCM_CYGNUS_MIPIPLL_CH4_UNUSED
     ch5_unused mipipll          6       BCM_CYGNUS_MIPIPLL_CH5_UNUSED
+
+Northstar and Northstar Plus
+------
+PLL and leaf clock compatible strings for Northstar and Northstar Plus are:
+ "brcm,nsp-armpll"
+ "brcm,nsp-genpll"
+ "brcm,nsp-lcpll0"
+
+The following table defines the set of PLL/clock index and ID for Northstar and
+Northstar Plus.  These clock IDs are defined in:
+    "include/dt-bindings/clock/bcm-nsp.h"
+
+    Clock	Source		Index	ID
+    ---		-----		-----	---------
+    crystal	N/A		N/A	N/A
+
+    armpll	crystal		N/A	N/A
+
+    genpll	crystal		0	BCM_NSP_GENPLL
+    phy		genpll		1	BCM_NSP_GENPLL_PHY_CLK
+    ethernetclk	genpll		2	BCM_NSP_GENPLL_ENET_SW_CLK
+    usbclk	genpll		3	BCM_NSP_GENPLL_USB_PHY_REF_CLK
+    iprocfast	genpll		4	BCM_NSP_GENPLL_IPROCFAST_CLK
+    sata1	genpll		5	BCM_NSP_GENPLL_SATA1_CLK
+    sata2	genpll		6	BCM_NSP_GENPLL_SATA2_CLK
+
+    lcpll0	crystal		0	BCM_NSP_LCPLL0
+    pcie_phy	lcpll0		1	BCM_NSP_LCPLL0_PCIE_PHY_REF_CLK
+    sdio	lcpll0		2	BCM_NSP_LCPLL0_SDIO_CLK
+    ddr_phy	lcpll0		3	BCM_NSP_LCPLL0_DDR_PHY_CLK
-- 
1.9.1
