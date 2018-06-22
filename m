From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 22 Jun 2018 09:28:32 +0200
Subject: [PATCH v2] net: ethernet: stmmac: dwmac-rk: Add GMAC support for
 PX30
In-Reply-To: <7173b45f-17d3-2356-fede-28bdd5c658f2@rock-chips.com>
References: <1528956927-32440-1-git-send-email-david.wu@rock-chips.com>
 <2582999.2hZx6CH9S6@diego>
 <7173b45f-17d3-2356-fede-28bdd5c658f2@rock-chips.com>
Message-ID: <19622369.ojvgxrHm8t@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Am Freitag, 22. Juni 2018, 09:22:35 CEST schrieb David Wu:
> ? 2018?06?14? 16:30, Heiko St?bner ??:
> > And someone could convert the driver to use the new clk-bulk APIs [0],
> > so the large number of clk_prepare_enable calls would be a bit
> > trimmed down.
> 
> Some clocks need special treatment at special cases, may not know which 
> index is we need at clk_bulk_data struct.
> 1. At rmii mode, need to use mac_ref, mac_refout; but at rgmii, they are 
> not needed.
> 2. At rgmii mode, rx is coming in from external source, there is no 
> gate, and it is coming from mac_ref_clk at rmii mode, there is gate.
> 3. clk_mac needs to be configured rate 50M or 125M.
> 4. mac_clk_speed needs to be configured at PX30 Soc and next Socs.
> 
> It looks like use the clk-bulk, will not be more flexible, and we still 
> keep the present. What do you think?

yeah, you're probably right. I just saw all these clk_prepare_enable calls
and didn't think enough about the config side ;-) .


Heiko
