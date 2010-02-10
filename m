From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Feb 2010 22:40:30 +0000
Subject: [RFC 0/2] fix dma_map_sg not to do barriers for each buffer
In-Reply-To: <4B7324D3.1000509@xenotime.net>
References: <1265834250-29170-1-git-send-email-adharmap@codeaurora.org>
	<4B7324D3.1000509@xenotime.net>
Message-ID: <20100210224030.GC30854@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2010 at 01:27:47PM -0800, Randy Dunlap wrote:
> On 02/10/10 12:37, adharmap at codeaurora.org wrote:
> > From: Abhijeet Dharmapurikar <adharmap@quicinc.com>
> > 
> > Please refer to the post here
> > http://lkml.org/lkml/2010/1/4/347
> > 
> > These changes are to introduce barrierless dma_map_area and dma_unmap_area and
> > use them to map the buffers in the scatterlist. For the last buffer, call
> > the normal dma_map_area(aka with barriers) effectively executing the barrier
> > at the end of the operation.
> > 
> > Note that the barrierless operations are implemented for few arm
> > architectures only and I would implement for others once these are okayed by the
> > community.
> 
> So when you add these interfaces for other architectures, you will also
> update Documentation/DMA-API.txt,  right??

Do we need barrier-less interfaces for anything other than the dma_*_sg
functions?
