From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 14 Dec 2016 18:11:40 +0800
Subject: [PATCH 2/3] clk: rockchip: rk3399: export 480M_SRC clocks id for
 usbphy0/usbphy1
In-Reply-To: <1481710301-1454-1-git-send-email-zhengxing@rock-chips.com>
References: <1481710301-1454-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1481710301-1454-3-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch exports USBPHYx_480M_SRC clocks for usbphy.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3399.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 3490887..cf2af4c 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -411,9 +411,9 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	GATE(SCLK_USB2PHY1_REF, "clk_usb2phy1_ref", "xin24m", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(6), 6, GFLAGS),
 
-	GATE(0, "clk_usbphy0_480m_src", "clk_usbphy0_480m", 0,
+	GATE(SCLK_USBPHY0_480M_SRC, "clk_usbphy0_480m_src", "clk_usbphy0_480m", 0,
 			RK3399_CLKGATE_CON(13), 12, GFLAGS),
-	GATE(0, "clk_usbphy1_480m_src", "clk_usbphy1_480m", 0,
+	GATE(SCLK_USBPHY1_480M_SRC, "clk_usbphy1_480m_src", "clk_usbphy1_480m", 0,
 			RK3399_CLKGATE_CON(13), 12, GFLAGS),
 	MUX(0, "clk_usbphy_480m", mux_usbphy_480m_p, 0,
 			RK3399_CLKSEL_CON(14), 6, 1, MFLAGS),
-- 
2.7.4
