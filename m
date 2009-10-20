From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 20 Oct 2009 19:37:37 +0200
Subject: [PATCH] imx/gpio: Use handle_level_irq
In-Reply-To: <20091020081303.GO8818@pengutronix.de>
References: <1255983568-20958-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091020081303.GO8818@pengutronix.de>
Message-ID: <20091020173737.GA6819@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sascha,

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
The PMIC on pcm038 doesn't work anymore with handle_edge_irq since I
switched to using threaded irqs in the driver.  But as this won't hit
mainline before the next merge window that is fine for me, too.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
