From: robh@kernel.org (Rob Herring)
Date: Fri, 24 Jun 2016 10:52:44 -0500
Subject: [PATCH 1/2] clk: fixed-factor: Allow for a few clocks to change
 the parent rate
In-Reply-To: <20160622091555.18415-1-maxime.ripard@free-electrons.com>
References: <20160622091555.18415-1-maxime.ripard@free-electrons.com>
Message-ID: <20160624155244.GA9849@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 11:15:54AM +0200, Maxime Ripard wrote:
> The only way for a fixed factor clock to change its rate would be to change
> its parent rate.
> 
> Since passing blindly CLK_SET_RATE_PARENT might break a lot of platforms
> that were relying on the fact that the parent rate wouldn't change,
> introduce a compatible-based whitelist that will allow clocks to opt-in
> that flag.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../devicetree/bindings/clock/fixed-factor-clock.txt          |  4 ++++

I don't think we should be copying clk flags to DT as suggested.

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/clk-fixed-factor.c                                | 11 ++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
