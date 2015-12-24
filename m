From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 23 Dec 2015 16:11:38 -0800
Subject: [PATCH v2 0/5] clk: rockchip: fix handling of fractional dividers
In-Reply-To: <1450819682-4932-1-git-send-email-heiko@sntech.de>
References: <1450819682-4932-1-git-send-email-heiko@sntech.de>
Message-ID: <20151224001138.GA5927@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22, Heiko Stuebner wrote:
> Essentially unchanged from the first iteration from back in august, just
> including additional patches depending on that and fixing fractional
> dividers on the rk3036 and spdif parent settings.
> 
> In v1, Stephen seemed essentially ok with it but Mike put forward his wish
> to use his planned approach for connected clocks for handling this.
> 
> While that in itself will be very interesting also for handling Rockchip's
> armclk generically, we're now in the situation that everything related
> to audio output relies on working fractional dividers to produce the
> needed clock frequencies, making audio-output essentially non-working on
> all Rockchip socs in mainline at the moment.
> 
> So I'm somewhat hoping for some sort of intermediate solution here :-)

Intermediate solution applied.

Regards,
Mike

> 
> 
> changes in v2:
> - rebase original 3 patches onto 4.4
> - add the 2 new patches from other series, that need that change
> 
> Heiko Stuebner (3):
>   clk: add flag for clocks that need to be enabled on rate changes
>   clk: rockchip: handle mux dependency of fractional dividers
>   clk: rockchip: include downstream muxes into fractional dividers
> 
> Sjoerd Simons (1):
>   clk: rockchip: Allow the RK3288 SPDIF clocks to change their parent
> 
> Xing Zheng (1):
>   clk: rockchip: rk3036: include downstream muxes into fractional
>     dividers
> 
>  drivers/clk/clk.c                 |  18 +++++
>  drivers/clk/rockchip/clk-rk3036.c |  34 +++++-----
>  drivers/clk/rockchip/clk-rk3188.c |  80 +++++++++++-----------
>  drivers/clk/rockchip/clk-rk3288.c |  70 +++++++++----------
>  drivers/clk/rockchip/clk.c        | 137 ++++++++++++++++++++++++++++++++++----
>  drivers/clk/rockchip/clk.h        |  19 ++++++
>  include/linux/clk-provider.h      |   1 +
>  7 files changed, 254 insertions(+), 105 deletions(-)
> 
> -- 
> 2.6.4
> 
