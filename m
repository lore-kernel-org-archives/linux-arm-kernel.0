From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 24 Nov 2010 21:18:31 +0100
Subject: [PATCH] imx: dma: remove SDMA_IS_MERGED
In-Reply-To: <AANLkTingtkuvLE9TMxM5f=uwgK95Wfw8kPyXa_NxekEZ@mail.gmail.com>
References: <1290626971-14863-1-git-send-email-fabio.estevam@freescale.com>
	<20101124194439.GY4693@pengutronix.de>
	<AANLkTingtkuvLE9TMxM5f=uwgK95Wfw8kPyXa_NxekEZ@mail.gmail.com>
Message-ID: <20101124201831.GZ4693@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 06:07:18PM -0200, Fabio Estevam wrote:
> Hi Uwe,
> 
> 2010/11/24 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Hello Fabio,
> >
> > On Wed, Nov 24, 2010 at 05:29:31PM -0200, Fabio Estevam wrote:
> >> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> >> ---
> >> This allows imx-for-2.6.38 tree to build again.
> > The same patch is already in Sascha's imx-for-2.6.37 branch (and so in
> > for-next, too). ?There are some more fixes in for-.37 so I'd use the
> > for-next branch for now.
> 
> Thanks, I haven't noticed this. Will use for-next branch for now.
> 
> While at the dma topic: is anyone able to boot a kernel on MX51 with
> IMX_SDMA=y?
> 
> I enabled early printk support, but no kernel messages appear after:
> Uncompressing Linux... done, booting the kernel.
> 
> This also happens on the for-next branch.
I usually prefer just using DEBUG_LL and put

	#ifdef CONFIG_DEBUG_LL
		void printch(char);
		printch(c);
	#endif

into emit_log_char.  But I think that's only because I don't know how to
use early printk properly.  (You might need an additional kernel
parameter?!)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
