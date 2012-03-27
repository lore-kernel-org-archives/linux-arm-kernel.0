From: tony.luck@intel.com (Tony Luck)
Date: Tue, 27 Mar 2012 14:20:05 -0700
Subject: [PATCH 05/14] IA64: adapt for dma_map_ops changes
In-Reply-To: <1324643253-3024-6-git-send-email-m.szyprowski@samsung.com>
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
 <1324643253-3024-6-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CA+8MBbLAafFbVwviFmkjD0DNz5RsCbB_TNLL67wEi2k-hyXkXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 23, 2011 at 4:27 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
>
> Adapt core IA64 architecture code for dma_map_ops changes: replace
> alloc/free_coherent with generic alloc/free methods.
>
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> ?arch/ia64/hp/common/sba_iommu.c ? ? | ? 11 ++++++-----
> ?arch/ia64/include/asm/dma-mapping.h | ? 18 ++++++++++++------
> ?arch/ia64/kernel/pci-swiotlb.c ? ? ?| ? ?9 +++++----
> ?arch/ia64/sn/pci/pci_dma.c ? ? ? ? ?| ? ?9 +++++----
> ?4 files changed, 28 insertions(+), 19 deletions(-)

The series breaks bisection from part 2 (when the x86 part changes
lib/swiotlb.c)
until part 5 (when ia64 sees the changes to match).  You could either merge part
5 into part 2 (to make a combined x86+ia64 piece) ... or try to pull
the libswiotlb
changes into their own piece (which would have some of the ia64 and x86 bits).
Or at the very least minimize the breakage window by putting ia64
right after x86
in the patch sequence.

Otherwise seems OK

Acked-by: Tony Luck <tony.luck@intel.com>
