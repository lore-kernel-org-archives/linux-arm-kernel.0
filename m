From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 25 Feb 2010 08:13:56 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <Pine.LNX.4.44L0.1002241100190.2436-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1002241100190.2436-100000@iolanthe.rowland.org>
Message-ID: <1267046036.23523.1693.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-02-24 at 11:19 -0500, Alan Stern wrote:
> > It is but I'm not confident the responsibility for doing that
> cleanup
> > is at the HCD level. That would impact a lot of HCD activities that
> > don't need such flushing since the use of the page is purely
> in-kernel.
> 
> That's right.  The HCD merely puts data wherever it's told to.  It 
> doesn't know whether the destination is in the page cache, in 
> userspace, or anywhere else.  The same is true for usb-storage.

I'm surprised that usb-storage has an issue here. It shouldn't afaik,
since it's just a SCSI driver (or not anymore ?) and the BIO or
filesystems handle things there no ? I haven't seen a single call to
flush_dcache_page() in any of drivers/scsi, drivers/ata or drivers/ide
when I looked...

Cheers,
Ben.
