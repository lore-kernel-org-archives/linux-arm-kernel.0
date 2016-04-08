From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 8 Apr 2016 11:21:05 -0400 (EDT)
Subject: [PATCH] usb: core: buffer: avoid NULL pointer dereferrence
In-Reply-To: <20160408140701.GA3547@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1604081120190.2069-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Apr 2016, Greg Kroah-Hartman wrote:

> On Fri, Apr 08, 2016 at 05:08:03PM +0800, Chunfeng Yun wrote:
> > NULL pointer dereferrence will happen when class driver
> > wants to allocate zero length buffer and pool_max[0]
> > can't be used, so skip reserved pool in this case.
> 
> Why would a driver want to allocate a 0 length buffer?  What driver does
> this?
> 
> Shouldn't we fix that issue instead?

And even if a driver does want to allocate a 0-length buffer, shouldn't 
the function simply return early instead of running through all its 
calculations?

Alan Stern
