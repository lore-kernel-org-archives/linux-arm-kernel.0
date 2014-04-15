From: lee.essen@nowonline.co.uk (Lee Essen)
Date: Tue, 15 Apr 2014 09:43:38 +0400
Subject: dma_alloc_coherent and cache?
Message-ID: <45E047AA-4C3B-4645-A590-5B75A1729ADA@nowonline.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm working on a driver for a Marvell switch device (98dx4122) where the basic interface closely resembles the mv643xx_eth device.

(I should say this is a bit of a personal project to experiment with a trendnet switch, not affiliated with any commercial activities.)

GPL code from Marvell is available for an old kernel, so I have been working to use the mv643xx_eth concepts and at least get basic functionality up an running on the current kernel version.

At a high level I have it working, however I get regular (reproducible) hangs and I suspect it's to do with the writes to the descriptiors (from dma_alloc_coherent) being buffered or cached and not making it to the device when dma is triggered.

My theory is based on the fact that the hang always seems to happen at the point of enabling dma for transmit, and occasionally I get a packet out which is corrupt ... and if I add lots of debug printk's or delay loops then it happens less frequently.

The original GPL code has some functions in to invalidate/clear the L2 cache, but no other driver seems to do this, so it doesn't feel like it's a good solution.

It's a feroceon cpu, and I've tried disabling the L2 controller and also the d-cache - neither of which made any difference.

So I'm now completely out of ideas and way out of my depth ;-) 

Any suggestions would be greatly appreciated.

Regards,

Lee.
