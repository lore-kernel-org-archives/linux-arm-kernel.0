From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 24 Feb 2010 11:19:28 -0500 (EST)
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1266979632.23523.1668.camel@pasglop>
Message-ID: <Pine.LNX.4.44L0.1002241100190.2436-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Feb 2010, Benjamin Herrenschmidt wrote:

> > The PIO HCD drivers, however, don't call flush_dcache_page(). Is it possible
> > that the HCD could transfer data into a page cache page already mapped
> > in user space? My understanding is that the scenario above is possible.
> 
> It is but I'm not confident the responsibility for doing that cleanup
> is at the HCD level. That would impact a lot of HCD activities that
> don't need such flushing since the use of the page is purely in-kernel.

That's right.  The HCD merely puts data wherever it's told to.  It 
doesn't know whether the destination is in the page cache, in 
userspace, or anywhere else.  The same is true for usb-storage.

Alan Stern
