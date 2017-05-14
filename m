From: ayaka@soulik.info (Randy Li)
Date: Sun, 14 May 2017 14:50:09 +0800
Subject: [PATCH] clk: rockchip: rk3288: prefer vdpu for vcodec clock source
Message-ID: <20170514065009.3047-1-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RK3288 CRU system clock solution would suggest use
the vdpu clock source for the VPU(aclk_vpu and hclk_vpu).

Reading the registers of VPU(both VEPU and VDPU) would become all high
when the vepu is used as the clock source. It may be a bug in the SoC,
not sure whether it is fixed at RK3288W.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/clk/rockchip/clk-rk3288.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 68ba7d4..886b249 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -198,7 +198,7 @@ PNAME(mux_hsadcout_p)	= { "hsadc_src", "ext_hsadc" };
 PNAME(mux_edp_24m_p)	= { "ext_edp_24m", "xin24m" };
 PNAME(mux_tspout_p)	= { "cpll", "gpll", "npll", "xin27m" };
 
-PNAME(mux_aclk_vcodec_pre_p)	= { "aclk_vepu", "aclk_vdpu" };
+PNAME(mux_aclk_vcodec_pre_p)	= { "aclk_vdpu", "aclk_vepu" };
 PNAME(mux_usbphy480m_p)		= { "sclk_otgphy1_480m", "sclk_otgphy2_480m",
 				    "sclk_otgphy0_480m" };
 PNAME(mux_hsicphy480m_p)	= { "cpll", "gpll", "usbphy480m_src" };
-- 
2.9.3
