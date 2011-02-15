From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 16 Feb 2011 06:39:42 +0800
Subject: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <20110214165958.GH10709@pengutronix.de>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
	<1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
	<20110214165958.GH10709@pengutronix.de>
Message-ID: <20110215223941.GJ10990@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Mon, Feb 14, 2011 at 05:59:58PM +0100, Wolfram Sang wrote:
> On Mon, Feb 14, 2011 at 10:32:20AM +0800, Shawn Guo wrote:
> > This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> > The driver calls into mxs-dma via generic dmaengine api for both pio
> > and data transfer.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> 
> While trying, I got this lockdep-warning and BUG. It might be that my setup is
> wrong, causing all these timeouts. But they probably are meant to be handled
> more gracefully? I can continue testing tomorrow, maybe this report already
> helps identifying a problem?
> 
Ah, yes.  I can also see the problem here after turning on
DEBUG_SPINLOCK.  I really should always turn it on in daily
development.

Thanks for catching.  I will fix it in v3.

Regards,
Shawn
