From: anup.patel@broadcom.com (Anup Patel)
Date: Sat,  6 May 2017 17:24:37 +0530
Subject: [PATCH 02/11] dt-bindings: clk: Extend binding doc for Stingray SOC
In-Reply-To: <1494071686-19098-1-git-send-email-anup.patel@broadcom.com>
References: <1494071686-19098-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1494071686-19098-3-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sandeep Tripathy <sandeep.tripathy@broadcom.com>

Update iproc clock dt-binding documentation with
Stingray pll and clock details.

Signed-off-by: Sandeep Tripathy <sandeep.tripathy@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../bindings/clock/brcm,iproc-clocks.txt           | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt b/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
index 6f66e9a..f2c5f0e4a 100644
--- a/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
@@ -219,3 +219,79 @@ BCM63138
 --------
 PLL and leaf clock compatible strings for BCM63138 are:
     "brcm,bcm63138-armpll"
+
+Stingray
+-----------
+PLL and leaf clock compatible strings for Stingray are:
+    "brcm,sr-genpll0"
+    "brcm,sr-genpll1"
+    "brcm,sr-genpll2"
+    "brcm,sr-genpll3"
+    "brcm,sr-genpll4"
+    "brcm,sr-genpll5"
+    "brcm,sr-genpll6"
+
+    "brcm,sr-lcpll0"
+    "brcm,sr-lcpll1"
+    "brcm,sr-lcpll-pcie"
+
+
+The following table defines the set of PLL/clock index and ID for Stingray.
+These clock IDs are defined in:
+    "include/dt-bindings/clock/bcm-sr.h"
+
+    Clock		Source		Index	ID
+    ---			-----		-----	---------
+    crystal		N/A		N/A	N/A
+    crmu_ref25m		crystal		N/A	N/A
+
+    genpll0		crystal		0	BCM_SR_GENPLL0
+    clk_125m		genpll0		1	BCM_SR_GENPLL0_125M_CLK
+    clk_scr		genpll0		2	BCM_SR_GENPLL0_SCR_CLK
+    clk_250		genpll0		3	BCM_SR_GENPLL0_250M_CLK
+    clk_pcie_axi	genpll0		4	BCM_SR_GENPLL0_PCIE_AXI_CLK
+    clk_paxc_axi_x2	genpll0		5	BCM_SR_GENPLL0_PAXC_AXI_X2_CLK
+    clk_paxc_axi	genpll0		6	BCM_SR_GENPLL0_PAXC_AXI_CLK
+
+    genpll1		crystal		0	BCM_SR_GENPLL1
+    clk_pcie_tl		genpll1		1	BCM_SR_GENPLL1_PCIE_TL_CLK
+    clk_mhb_apb		genpll1		2	BCM_SR_GENPLL1_MHB_APB_CLK
+
+    genpll2		crystal		0	BCM_SR_GENPLL2
+    clk_nic		genpll2		1	BCM_SR_GENPLL2_NIC_CLK
+    clk_ts_500_ref	genpll2		2	BCM_SR_GENPLL2_TS_500_REF_CLK
+    clk_125_nitro	genpll2		3	BCM_SR_GENPLL2_125_NITRO_CLK
+    clk_chimp		genpll2		4	BCM_SR_GENPLL2_CHIMP_CLK
+    clk_nic_flash	genpll2		5	BCM_SR_GENPLL2_NIC_FLASH
+
+    genpll3		crystal		0	BCM_SR_GENPLL3
+    clk_hsls		genpll3		1	BCM_SR_GENPLL3_HSLS_CLK
+    clk_sdio		genpll3		2	BCM_SR_GENPLL3_SDIO_CLK
+
+    genpll4		crystal		0	BCM_SR_GENPLL4
+    ccn			genpll4		1	BCM_SR_GENPLL4_CCN_CLK
+    clk_tpiu_pll	genpll4		2	BCM_SR_GENPLL4_TPIU_PLL_CLK
+    noc_clk		genpll4		3	BCM_SR_GENPLL4_NOC_CLK
+    clk_chclk_fs4	genpll4		4	BCM_SR_GENPLL4_CHCLK_FS4_CLK
+    clk_bridge_fscpu	genpll4		5	BCM_SR_GENPLL4_BRIDGE_FSCPU_CLK
+
+
+    genpll5		crystal		0	BCM_SR_GENPLL5
+    fs4_hf_clk		genpll5		1	BCM_SR_GENPLL5_FS4_HF_CLK
+    crypto_ae_clk	genpll5		2	BCM_SR_GENPLL5_CRYPTO_AE_CLK
+    raid_ae_clk		genpll5		3	BCM_SR_GENPLL5_RAID_AE_CLK
+
+    genpll6		crystal		0	BCM_SR_GENPLL6
+    48_usb		genpll6		1	BCM_SR_GENPLL6_48_USB_CLK
+
+    lcpll0		crystal		0	BCM_SR_LCPLL0
+    clk_sata_refp 	lcpll0		1	BCM_SR_LCPLL0_SATA_REFP_CLK
+    clk_sata_refn	lcpll0		2	BCM_SR_LCPLL0_SATA_REFN_CLK
+    clk_usb_ref		lcpll0		3	BCM_SR_LCPLL0_USB_REF_CLK
+    sata_refpn		lcpll0		3	BCM_SR_LCPLL0_SATA_REFPN_CLK
+
+    lcpll1		crystal		0	BCM_SR_LCPLL1
+    wan 		lcpll1		1	BCM_SR_LCPLL0_WAN_CLK
+
+    lcpll_pcie		crystal		0	BCM_SR_LCPLL_PCIE
+    pcie_phy_ref 	lcpll1		1	BCM_SR_LCPLL_PCIE_PHY_REF_CLK
-- 
2.7.4
