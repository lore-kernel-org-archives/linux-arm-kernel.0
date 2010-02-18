From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Feb 2010 08:53:36 +0000
Subject: Kernel panic due to page migration accessing memory holes
In-Reply-To: <4B7C8DC2.3060004@codeaurora.org>
References: <4B7C8DC2.3060004@codeaurora.org>
Message-ID: <20100218085336.GB848@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2010 at 04:45:54PM -0800, Michael Bohan wrote:
> I have encountered a kernel panic on the ARM/msm platform in the mm  
> migration code on 2.6.29.  My memory configuration has two discontiguous  
> banks per our ATAG definition.   These banks end up on addresses that  
> are 1 MB aligned.  I am using FLATMEM (not SPARSEMEM), but my  
> understanding is that SPARSEMEM should not be necessary to support this  
> configuration.  Please correct me if I'm wrong.

Make sure you have ARCH_HAS_HOLES_MEMORYMODEL enabled.
