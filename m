From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 29 Oct 2018 09:57:04 +0000
Subject: [PATCH V3] arm64: Don't flush tlb while clearing the accessed bit
In-Reply-To: <1540805158-618-1-git-send-email-amhetre@nvidia.com>
References: <1540805158-618-1-git-send-email-amhetre@nvidia.com>
Message-ID: <b014451f-d81e-1d02-4b04-f719bca6621d@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 29/10/2018 09:25, Ashish Mhetre wrote:
> From: Alex Van Brunt <avanbrunt@nvidia.com>
> 
> Accessed bit is used to age a page and in generic implementation there is
> flush_tlb while clearing the accessed bit.
> Flushing a TLB is overhead on ARM64 as access flag faults don't get
> translation table entries cached into TLB's. Flushing TLB is not necessary
> for this. Clearing the accessed bit without flushing TLB doesn't cause data
> corruption on ARM64.
> In our case with this patch, speed of reading from fast NVMe/SSD through
> PCIe got improved by 10% ~ 15% and writing got improved by 20% ~ 40%.
> So for performance optimisation don't flush TLB when clearing the accessed
> bit on ARM64.
> x86 made the same optimization even though their TLB invalidate is much
> faster as it doesn't broadcast to other CPUs.
> Please refer to:
> 'commit b13b1d2d8692 ("x86/mm: In the PTE swapout page reclaim case clear
> the accessed bit instead of flushing the TLB")'
> 
> Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---

Please make sure you state here below the above line what has been
changed between each version of the patch.

Thanks
Jon

-- 
nvpublic
