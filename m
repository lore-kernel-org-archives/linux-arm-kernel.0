From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Dec 2013 00:17:28 +0000
Subject: [PATCH] serial: rewrite pxa2xx-uart to use 8250_core
In-Reply-To: <20131206000253.GC21358@kroah.com>
References: <20131205043544.GA28580@kroah.com>
 <1386286149-2855-1-git-send-email-ynvich@gmail.com>
 <20131206000253.GC21358@kroah.com>
Message-ID: <20131206001728.GJ4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 04:02:53PM -0800, Greg Kroah-Hartman wrote:
> On Fri, Dec 06, 2013 at 03:28:37AM +0400, Sergei Ianovich wrote:
> > pxa2xx-uart was a separate uart platform driver. It was declaring
> > the same device names and numbers as 8250 driver. As a result,
> > it was impossible to use 8250 driver on PXA SoCs.
> > 
> > Upon closer examination pxa2xx-uart turned out to be a clone of
> > 8250_core driver.
> > 
> > Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
> > CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Wonderful!
> 
> Can someone else test this to verify it works for them on their platform
> as well?

I may be able to - one of the downsides though is that many of these
systems had hard-coded scripts which started a getty on the original
port - and that kind of makes it difficult to sort out.  This kind of
change becomes very much one of Linus' "flag days".

So I'd suggest that we have a period where the old driver is still
available, so at least people can choose to use the old major/minor
numbers for a while.
