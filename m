From: robh@kernel.org (Rob Herring)
Date: Tue, 14 Aug 2018 10:08:57 -0600
Subject: [PATCH 2/3] clk: imx6q: optionally get CCM inputs via standard
 clock handles
In-Reply-To: <20180731102009.6710-2-l.stach@pengutronix.de>
References: <20180731102009.6710-1-l.stach@pengutronix.de>
 <20180731102009.6710-2-l.stach@pengutronix.de>
Message-ID: <20180814160857.GA11979@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 12:20:08PM +0200, Lucas Stach wrote:
> When specifying external clock inputs to the CCM the current code
> requires the clocks to be in a "clocks" child node of the DT root.
> This is not really conformant with DT best practices.
> 
> To avoid the need to deviate from those best practices, allow the
> clock inputs to be specifies via standard clock handles. This is
> in line with how drivers of the later CCM driver revisions on
> newer i.MX SoCs handle this.
> 
> As we can't retroactively change the DT binding, allow this as an
> option with a fallback to the old way of how this has been handled.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  .../devicetree/bindings/clock/imx6q-clock.txt |  5 +++++

Ignoring what my bot said if there's no other changes needed,

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/imx/clk-imx6q.c                   | 22 ++++++++++++++-----
>  2 files changed, 22 insertions(+), 5 deletions(-)
