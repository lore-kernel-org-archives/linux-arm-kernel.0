From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 16 Nov 2014 00:41:27 +0100
Subject: [PATCH] clk: rockchip: fix clock select order for usbphy480m_src
In-Reply-To: <1415866309-3277-1-git-send-email-kever.yang@rock-chips.com>
References: <1415866309-3277-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <8965478.SpyRElfG0W@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 13. November 2014, 16:11:49 schrieb Kever Yang:
> According to rk3288 trm, the mux selector locate at bit[12:11]
> of CRU_CLKSEL13_CON shows:
> 2'b00: select HOST0 USB pll clock (clk_otgphy1)
> 2'b01: select HOST1 USB pll clock (clk_otgphy2)
> 2'b10: select OTG USB pll clock   (clk_otgphy0)
> 
> The clock map is in Fig. 3-4 CRU Clock Architecture Diagram 3
> - clk_otgphy0 -> USB PHY OTG
> - clk_otgphy1 -> USB PHY host0
> - clk_otgphy2 -> USB PHY host1
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

applied this to my clk branch for 3.19


Heiko
