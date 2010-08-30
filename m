From: clemens@ladisch.de (Clemens Ladisch)
Date: Mon, 30 Aug 2010 10:27:50 +0200
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <20100825155814.25c783c7.akpm@linux-foundation.org>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
Message-ID: <4C7B6B86.3080502@ladisch.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Morton wrote:
> It would help (a lot) if we could get more attention and buyin and
> fedback from the potential clients of this code.  rmk's feedback is
> valuable.  Have we heard from the linux-media people?  What other
> subsystems might use it?  ieee1394 perhaps?

All FireWire controllers are OHCI and use scatter-gather lists.

Most USB controllers require continuous memory for USB packets; the USB
framework has its own DMA buffer cache.

Some sound cards have no IOMMU; the ALSA framework preallocates buffers
for those.


Regards,
Clemens
