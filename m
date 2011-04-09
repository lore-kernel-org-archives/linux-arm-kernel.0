From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Apr 2011 08:16:24 +0100
Subject: V4L/ARM: videobuf-dma-contig no longer works on my ARM machine
	(was: [PATCH v3] SoC Camera: add driver for OMAP1 camera interface)
In-Reply-To: <201104090333.52312.jkrzyszt@tis.icnet.pl>
References: <201009301335.51643.jkrzyszt@tis.icnet.pl>
	<Pine.LNX.4.64.1103231056360.6836@axis700.grange>
	<201104090333.52312.jkrzyszt@tis.icnet.pl>
Message-ID: <20110409071624.GE5573@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 09, 2011 at 03:33:39AM +0200, Janusz Krzysztofik wrote:
> Since there were no actual problems reported before, I suppose the old 
> code, which was passing to remap_pfn_range() a physical page number 
> calculated from dma_alloc_coherent() privided dma_handle, worked 
> correctly on all platforms actually using videobud-dma-config. Now, on 
> my ARM machine, a completely different, then completely wrong physical 
> address, calculated as virt_to_phys(dma_alloc_coherent()), is used 
> instead of the dma_handle, which causes the machine to hang.

virt_to_phys(dma_alloc_coherent()) is and always has been invalid, and
will break on several architectures apart from ARM.
