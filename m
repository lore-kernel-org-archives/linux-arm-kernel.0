From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 25 Nov 2014 12:28:10 +0100
Subject: [PATCH v2 0/4] clk: rockchip: allow adjusting pll rates on init
In-Reply-To: <1416512333-15438-1-git-send-email-heiko@sntech.de>
References: <1416512333-15438-1-git-send-email-heiko@sntech.de>
Message-ID: <1753789.atZ8FgoESr@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 20. November 2014, 20:38:49 schrieb Heiko Stuebner:
> It was found that some firmware versions initialized the pll rates using
> suboptimal parameters to achieve frequencies the actual rate table contained
> better parameters for.
> 
> Therefore this series first adds the possibility to create pll-specific
> flags and then adds a flag to adjust the pll rate on init to the parameters
> from the rate table.
> 
> changes since v1:
> - move population of pll_mux before registering the core pll clock
>   null pointer exception in the _set_rate callback when called from init
> 
> Heiko Stuebner (4):
>   clk: rockchip: add ability to specify pll-specific flags
>   clk: rockchip: setup pll_mux data earlier
>   clk: rockchip: add optional sync to pll rate parameters
>   clk: rockchip: add ROCKCHIP_PLL_SYNC_RATE flag to some plls

with Mike's green-light, I've now added these to my clk branch with Kevers 
tags added.
