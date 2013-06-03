From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Jun 2013 23:15:32 +0800
Subject: [PATCH] ARM: mxs: icoll: Fix interrupts gpio bank 0
In-Reply-To: <20130529144256.GD29528@S2101-09.ap.freescale.net>
References: <1369753257-11091-1-git-send-email-mpa@pengutronix.de>
 <20130529144256.GD29528@S2101-09.ap.freescale.net>
Message-ID: <20130603151530.GB23090@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 10:42:58PM +0800, Shawn Guo wrote:
> On Tue, May 28, 2013 at 05:00:57PM +0200, Markus Pargmann wrote:
> > The mxs interrupt controller does not support polling for interrupts,
> > but the driver still does it, which is a relict from
> > pre-MULTI_IRQ_HANDLER times.
> > 
> > The existing code assumes that 0x7f means no interrupt, but this value
> > is an actually valid irq number, namely gpio bank 0's irq. This results
> > in the driver not detecting when irq 0x7f is active which makes the
> > machine effectively dead lock.
> > 
> > This patch removes the interrupt poll loop and allows usage of gpio0
> > interrupt without an infinite loop.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > Cc: stable at vger.kernel.org
> 
> Thomas, can you please help handle the fix?  If yes, here is my ack.
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Otherwise, I can send it through arm-soc tree if you're fine with it.

Thomas,

I'm sending the fix through arm-soc, and let me know if you have problem
with that.

Shawn
