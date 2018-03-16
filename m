From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 16 Mar 2018 11:10:19 +0100
Subject: [PATCH v2 4/4] clk: imx: add clock driver for i.MX8MQ CCM
In-Reply-To: <20180315213304.ejvgpkhxtblr6xb3@pengutronix.de>
References: <20180201175412.9480-1-l.stach@pengutronix.de>
 <20180201175412.9480-4-l.stach@pengutronix.de>
 <20180315213304.ejvgpkhxtblr6xb3@pengutronix.de>
Message-ID: <1521195019.3492.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 15.03.2018, 22:33 +0100 schrieb Sascha Hauer:
> On Thu, Feb 01, 2018 at 06:54:12PM +0100, Lucas Stach wrote:
> > Add driver for the Clock Control Module found on i.MX8MQ.
> > 
> > This is largely based on the downstream driver from Anson Huang and
> > Bai Ping at NXP, with only some small adaptions to mainline from me.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 
> A general thought: The i.MX8M finally has a consistent clock tree. We
> have for example 70 Peripheral clock slices consisting of a mux, a gate
> and two dividers, all 70 looking the same.
> For these it might make sense to create a more complex clock type
> providing mux, gate and set rate functionality in one clock. This would
> drastically reduce the number of clocks we have to handle.

I agree. It seems we are missing the 4.17 merge window with this
anyways, due to the large number of changes still required and time
constraints on my side, so a larger rework of the driver might be
possible if we target 4.18.

Regards,
Lucas
