From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 1 Nov 2009 21:39:59 +0100
Subject: [PATCH] imx/gpio: Use handle_level_irq
In-Reply-To: <20091020081303.GO8818@pengutronix.de>
References: <1255983568-20958-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091020081303.GO8818@pengutronix.de>
Message-ID: <20091101203959.GC18116@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2009 at 10:13:03AM +0200, Sascha Hauer wrote:
> On Mon, Oct 19, 2009 at 10:19:28PM +0200, Uwe Kleine-K?nig wrote:
> > According to Russell King handle_edge_irq is only useful for "edge-based
> > inputs where the controller does not remember transitions with the input
> > masked."
> > 
> > So using handle_edge_irq unconditionally for both edge and level irqs is
> > wrong.  Testing showed that the controller does remember transitions
> > while the interrupt is masked.  So use handle_level_irq unconditionally.
> 
> As this fixes only rt kernels and we have no reports that something is
> not working on non rt kernels I suggest putting this into the next merge
> window.
I didn't find my patch in your imx tree.  Assuming I don't have
overlooked it, what is stopping you?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
