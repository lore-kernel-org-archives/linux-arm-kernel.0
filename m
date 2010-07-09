From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 09 Jul 2010 16:02:26 +0100
Subject: [PATCH v2 3/3] ARM: Add barriers to the
	I/OaccessorsifARM_DMA_MEM_BUFFERABLE
In-Reply-To: <20100709143452.GJ22845@n2100.arm.linux.org.uk>
References: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
	<20100709110814.11333.83771.stgit@e102109-lin.cambridge.arm.com>
	<1278675696.11895.37.camel@e102109-lin.cambridge.arm.com>
	<20100709121629.GE22845@n2100.arm.linux.org.uk>
	<1278680538.11895.49.camel@e102109-lin.cambridge.arm.com>
	<1278685283.11895.52.camel@e102109-lin.cambridge.arm.com>
	<20100709143452.GJ22845@n2100.arm.linux.org.uk>
Message-ID: <1278687746.11895.54.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-07-09 at 15:34 +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 09, 2010 at 03:21:23PM +0100, Catalin Marinas wrote:
> > The patch below changes the __raw_* accessors to inline functions. Do
> > you see any problem with this? This would be needed even without the I/O
> > ordering patches.
> 
> I'd suggest you try building a kernel before and after this patch and
> compare the sizes - and then look at the disassembly associated with
> these accessors.

I tried and the difference is quite big - nearly 78KB for a Thumb-2
kernel (with relatively new compiler). So I'll keep the original do
{...} while (0) implementation and propose a patch for the e1000.

-- 
Catalin
