From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Jul 2011 12:27:02 +0100
Subject: [PATCH v3 5/6] ARM: mxs: add usb phy operations
In-Reply-To: <20110727080315.GN20587@pengutronix.de>
References: <1311744574-3610-1-git-send-email-tony.lin@freescale.com>
	<1311744574-3610-6-git-send-email-tony.lin@freescale.com>
	<20110727080315.GN20587@pengutronix.de>
Message-ID: <20110728112702.GE31473@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2011 at 10:03:15AM +0200, Sascha Hauer wrote:
> On Wed, Jul 27, 2011 at 01:29:33PM +0800, Tony Lin wrote:
> > +	if (!ppriv->phy_regs || !ppriv->ctrl_regs) {
> > +		iounmap(ppriv->phy_regs);
> > +		iounmap(ppriv->ctrl_regs);
> > +		return -ENOMEM;
> > +	}
> 
> So you call iounmap(0) here.

That is not a problem.  iounmap() is like kfree().  It's designed to cope
with NULL.
