From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 17 Nov 2014 13:53:46 +0530
Subject: [PATCH] dmaengine: pl330: Fix linker error "undefined
 reference to `__aeabi_uldivmod'"
In-Reply-To: <1415898688.1787.6.camel@linaro.org>
References: <1415896047.1787.4.camel@linaro.org>
 <20141113170104.GP24582@intel.com>
 <1415898688.1787.6.camel@linaro.org>
Message-ID: <20141117082346.GQ24582@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 05:11:28PM +0000, Jon Medhurst (Tixy) wrote:
> On Thu, 2014-11-13 at 22:31 +0530, Vinod Koul wrote:
> > On Thu, Nov 13, 2014 at 04:27:27PM +0000, Jon Medhurst (Tixy) wrote:
> > > 32-bit ARM kernels may have a 64-bit dma_addr_t but have no
> > > implementation of the compiler helper for 64-bit unsigned division,
> > > therefore the use of the modulo operator in pl330_prep_dma_memcpy causes
> > > the link error "undefined reference to `__aeabi_uldivmod'"
> > > 
> > > As the burst value is always a power of two we can fix the problem, and
> > > make the code more efficient, by replacing "% burst" with "& (burst-1)".
> > > 
> > > Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > > ---
> > > 
> > > Vinod. I haven't added a 'Fixes:' line because I was unsure if the patch
> > > in linux-next is part of a stable branch or if the SHA1 might change
> > > before hitting mainline. If it stable then the line should be...
> > > 
> > > Fixes: 63369d0a96dc ("dmaengine: pl330: Align DMA memcpy operations to MFIFO width")
> > I have applied this for now but...
> > 
> > While at it and also related to Fixes, typically the fixes branch wont be
> > rebased before its sent to Linus and merged. But this is introduced in patch
> > which is sent, should I just fold it in and not cause this regression in
> > first place...?
> 
> I have no objection to folding it in, but then doesn't that remove
> credit for Fengguang Wu's test system for finding and reporting errors?
I added entry for that and retiained credit to him.

-- 
~Vinod
