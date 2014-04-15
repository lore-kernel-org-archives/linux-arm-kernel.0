From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Tue, 15 Apr 2014 14:54:22 -0700
Subject: dma_alloc_coherent and cache?
In-Reply-To: <45E047AA-4C3B-4645-A590-5B75A1729ADA@nowonline.co.uk>
References: <45E047AA-4C3B-4645-A590-5B75A1729ADA@nowonline.co.uk>
Message-ID: <534DAA8E.1090904@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/14/2014 10:43 PM, Lee Essen wrote:
> Hi,
> 
> I'm working on a driver for a Marvell switch device (98dx4122) where the basic interface closely resembles the mv643xx_eth device.
> 
> (I should say this is a bit of a personal project to experiment with a trendnet switch, not affiliated with any commercial activities.)
> 
> GPL code from Marvell is available for an old kernel, so I have been working to use the mv643xx_eth concepts and at least get basic functionality up an running on the current kernel version.
> 
> At a high level I have it working, however I get regular (reproducible) hangs and I suspect it's to do with the writes to the descriptiors (from dma_alloc_coherent) being buffered or cached and not making it to the device when dma is triggered.
> 

Have you verified that a wmb() precedes transferring ownership of the descriptor to the controller
and the cpu does not touch the descriptor afterwards?


Regards
Troy
