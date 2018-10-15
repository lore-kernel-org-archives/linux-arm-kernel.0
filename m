From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 15 Oct 2018 10:01:01 -0700
Subject: [PATCH 2/3] clk: imx6q: optionally get CCM inputs via standard
 clock handles
In-Reply-To: <AM0PR04MB4211DE29E5644C8C9A33278780310@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180731102009.6710-1-l.stach@pengutronix.de>
 <20180731102009.6710-2-l.stach@pengutronix.de>
 <AM0PR04MB4211DE29E5644C8C9A33278780310@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <153962286120.5275.13550019093922282541@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting A.s. Dong (2018-08-21 01:56:09)
> Hi Lucas,
> 
> > -----Original Message-----
> > From: Lucas Stach <l.stach@pengutronix.de>
> > Sent: Tuesday, July 31, 2018 6:20 PM
> 
> [...]
> 
> > When specifying external clock inputs to the CCM the current code requires
> > the clocks to be in a "clocks" child node of the DT root.
> > This is not really conformant with DT best practices.
> > 
> > To avoid the need to deviate from those best practices, allow the clock inputs
> > to be specifies via standard clock handles. This is in line with how drivers of
> > the later CCM driver revisions on newer i.MX SoCs handle this.
> > 
> > As we can't retroactively change the DT binding, allow this as an option with a
> > fallback to the old way of how this has been handled.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  .../devicetree/bindings/clock/imx6q-clock.txt |  5 +++++
> >  drivers/clk/imx/clk-imx6q.c                   | 22 ++++++++++++++-----
> >  2 files changed, 22 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > index a45ca67a9d5f..ce6aa9920c05 100644
> > --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > @@ -6,6 +6,11 @@ Required properties:
> >  - interrupts: Should contain CCM interrupt
> >  - #clock-cells: Should be <1>
> > 
> > +Optional properties:
> > +- clocks: list of clock specifiers, must contain an entry for each entry
> > +          in clock-names
> > +- clock-names: valid names are "osc", "ckil", "ckil", "anaclk1" and "anaclk2"
> 
> A minor issue: 
> The third name should be "ckih1".
> 
> Otherwise:
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> 

Is this going to be resent? I don't see anything new and there are
review comments on this patch series so I'm dropping it from the clk
review queue. Please resend.
