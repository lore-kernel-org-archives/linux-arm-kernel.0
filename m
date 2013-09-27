From: greg@kroah.com (Greg KH)
Date: Fri, 27 Sep 2013 08:40:20 -0700
Subject: [PATCH V5 5/9] USB: OHCI: make ohci-at91 a separate driver
In-Reply-To: <Pine.LNX.4.44L0.1309271136160.10254-100000@netrider.rowland.org>
References: <20130927152521.GA8450@kroah.com>
 <Pine.LNX.4.44L0.1309271136160.10254-100000@netrider.rowland.org>
Message-ID: <20130927154020.GA3238@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 11:37:16AM -0400, Alan Stern wrote:
> On Fri, 27 Sep 2013, Greg KH wrote:
> 
> > On Fri, Sep 27, 2013 at 08:10:32AM -0700, Kevin Hilman wrote:
> > > Manjunath,
> > > 
> > > Manjunath Goudar <manjunath.goudar@linaro.org> writes:
> > > 
> > > > Separate the  TI OHCI Atmel host controller driver from ohci-hcd
> > > > host code so that it can be built as a separate driver module.
> > > > This work is part of enabling multi-platform kernels on ARM.
> > > 
> > > This broke booting on atmel sama5 boards (and likely others with the
> > > same conversion)...
> > 
> > Crap.
> > 
> > And it looks like Manjunath is now no longer working at Linaro, so these
> > patches are "abandoned" :(
> > 
> > Unless someone at Linaro steps up in the next few days to fix these,
> > I'll have to go revert them all.  Again.
> > 
> > bleah.
> 
> It's not so bad as all that.  The patch Kevin wrote duplicates what 
> ehci-hcd does.  It's an obvious oversight; I need to work harder at 
> keeping the two drivers in sync.

Ah, ok, so Kevin's patch should resolve it all?  That's good, I'll go
queue it up.

greg k-h
