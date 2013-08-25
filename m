From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 25 Aug 2013 16:14:00 +0530
Subject: [PATCH] dma/Kconfig: TI_EDMA needs to be boolean
In-Reply-To: <1377205404-16786-1-git-send-email-linux@roeck-us.net>
References: <1377205404-16786-1-git-send-email-linux@roeck-us.net>
Message-ID: <20130825104400.GJ8091@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 02:03:24PM -0700, Guenter Roeck wrote:
> Fix:
> 
> arch/arm/common/built-in.o: undefined reference to `edma_filter_fn'
> 
> seen with "make ARCH=arm allmodconfig"
> 
> Commit 6cba4355 (ARM: edma: Add DT and runtime PM support to the private EDMA
> API) adds a dependency on edma_filter_fn() into arch/arm/common/edma.c. Since
> this file is always built into the kernel, edma_filter_fn() must be built into
> the kernel as well.
Applied, thanks

~Vinod
