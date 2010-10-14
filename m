From: greg@kroah.com (Greg KH)
Date: Thu, 14 Oct 2010 11:47:53 -0700
Subject: [PATCH] serial/imx: check that the buffer is non-empty before
	sending it out
In-Reply-To: <20101014112735.GK10432@buzzloop.caiaq.de>
References: <20101008091640.GD29673@pengutronix.de>
	<1286960637-11600-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20101014112735.GK10432@buzzloop.caiaq.de>
Message-ID: <20101014184752.GB17096@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 14, 2010 at 01:27:35PM +0200, Daniel Mack wrote:
> On Wed, Oct 13, 2010 at 11:03:57AM +0200, Uwe Kleine-K?nig wrote:
> > From: Volker Ernst <volker.ernst@txtr.com>
> > 
> > The .start_tx callback (imx_start_tx here) isn't only called when the
> > buffer is non-empty.  E.g. after resume or when handshaking is enabled
> > and the other side starts to signal being ready.
> > 
> > So check for an empty puffer already before sending the first character.
> > This prevents sending out stale (or uninitialised) data.
> > 
> > Signed-off-by: Volker Ernst <volker.ernst@txtr.com>
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > Cc: Andy Green <andy@warmcat.com>
> > [ukl: reword commit log, put check in while condition]
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> > 
> > as I didn't sent a patch, here comes my current version.  Don't know if
> > it makes it easier to test for you ...
> > 
> > I faked Daniel's SoB as Andrew said he did, compressed the changelog a
> > bit and put the check in the while condition as I suggested.
> 
> FWIW, that looks good to me. Thanks for finishing the work :)

Nice, I've replaced the original patch in my tree with this one.

thanks,

greg k-h
