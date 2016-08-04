From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 04 Aug 2016 21:10:47 +0200
Subject: [PATCH v3 2/7] clk: rockchip: rk3399: export 480M_SRC clock id
 for usbphy0/usbphy1
In-Reply-To: <1470122401-31934-3-git-send-email-zhengxing@rock-chips.com>
References: <1470122401-31934-1-git-send-email-zhengxing@rock-chips.com>
 <1470122401-31934-3-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1918977.W0kRfKbZsD@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xing,

Am Dienstag, 2. August 2016, 15:19:56 schrieb Xing Zheng:
> Export these source clocks for usbphy.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

can you please provide a rationale why you need manual control over that 
intermediate clock?

The two usbphys seem to use the  clk_usb2phyX_ref clocks, generate the 480m 
clocks, but do not seem to need the clk_usbphyX_480m_src gates.

The clk_usbphyX_480m_src clocks on the other hand only lead to the 
clk_usbphy_480m mux, so I'd like some explanation on what you want to achieve 
here :-)


Thanks
Heiko
