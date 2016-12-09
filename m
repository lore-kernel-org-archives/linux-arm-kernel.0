From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Dec 2016 20:31:27 +0000
Subject: [PATCH 1/3] clkdev: add devm_get_clk_from_child()
In-Reply-To: <8737i3vtl7.wl%kuninori.morimoto.gx@renesas.com>
References: <874m2jvtmw.wl%kuninori.morimoto.gx@renesas.com>
 <8737i3vtl7.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20161209203127.GR14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 05:23:20AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Some driver is using this type of DT bindings for clock (more detail,
> see ${LINUX}/Documentation/devicetree/bindings/sound/simple-card.txt).
> 
> 	sound_soc {
> 		...
> 		cpu {
> 			clocks = <&xxx>;
> 			...
> 		};
> 		codec {
> 			clocks = <&xxx>;
> 			...
> 		};
> 	};
> 
> Current driver in this case uses of_clk_get() for each node, but there
> is no devm_of_clk_get() today.
> OTOH, the problem of having devm_of_clk_get() is that it encourages the
> use of of_clk_get() when clk_get() is more desirable.
> 
> Thus, this patch adds new devm_get_clk_from_chile() which explicitly
> reads as get a clock from a child node of this device.
> By this function, we can also use this type of DT bindings
> 
> 	sound_soc {
> 		clocks = <&xxx>, <&xxx>;
> 		clock-names = "cpu", "codec";
> 		...
> 		cpu {
> 			...
> 		};
> 		codec {
> 			...
> 		};
> 	};
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This looks lots better, thanks.

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
