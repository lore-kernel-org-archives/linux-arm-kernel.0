From: philippe.retornaz@epfl.ch (Philippe =?iso-8859-1?q?R=E9tornaz?=)
Date: Thu, 13 May 2010 19:04:42 +0200
Subject: [PATCH 1/1 v2] ehci-mxc: Fix mx31 OTG host initialisation
In-Reply-To: <20100512185005.GA28990@suse.de>
References: <1273587274-8045-1-git-send-email-philippe.retornaz@epfl.ch>
	<201005120923.48568.philippe.retornaz@epfl.ch>
	<20100512185005.GA28990@suse.de>
Message-ID: <201005131904.42319.philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mercredi, 12 mai 2010 20.50:05, Greg KH a ?crit :
> On Wed, May 12, 2010 at 09:23:48AM +0200, Philippe R?tornaz wrote:
> > Le mercredi, 12 mai 2010 01.38:12, Greg KH a ?crit :
> > > On Tue, May 11, 2010 at 04:14:34PM +0200, Philippe R?tornaz wrote:
> > > > On mx31 the OTG host initialisation fails if you need to have
> > > > an ULPI transfert to initialize the PHY.
> > > >
> > > > In order to be able to communicate with the PHY a complete reset
> > > > of the usb host is needed. After the PHY initialization the host
> > > > usb configuration registers need to be rewritten to avoid a host
> > > > controller lockup.
> > > >
> > > > Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
> > > > ---
> > > >  drivers/usb/host/ehci-mxc.c |   98
> > > > ++++++++++++++++++++++++++++++++++++++-----
> > >
> > > This patch doesn't apply anymore, can you redo it against the
> > > linux-next tree?
> >
> > It apply cleanly on next-20100512.
> >
> > It needs commit 5a25ad84e01173bb225285eb50f9af48ed1a7598 to apply, but
> > this one is in linux-next now.
> 
> Where is that patch from?  Some other tree?

Yes, it looks like it's from the mxc-master tree:
http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commitdiff;h=5a25ad84e01173bb225285eb50f9af48ed1a7598

Which has been merged inside linux-next.

Regards,
Philippe
