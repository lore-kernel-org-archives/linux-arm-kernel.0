From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 10 Oct 2014 13:08:03 +0200
Subject: [PATCH 0/6] KVM: handling of MMIO pass-through regions
In-Reply-To: <1410990981-665-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1410990981-665-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20141010110803.GC3717@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 02:56:15PM -0700, Ard Biesheuvel wrote:
> This is a followup to the patches 'kvm: define PAGE_S2_DEVICE as
> read-only by default' I sent out last week. Essentially build tested
> only: while QEMU on KVM still works correctly for my use case with
> these patches applied, it does not in fact use passthrough mappings
> of device memory.
> 
> Patch #1 is a trivial fix for an issue identified by sparse where we
> are calling memset(0) on 2 MB worth of pages.
> 
> Patch #2 fixes a potential NULL dereference in user_mem_abort()
> 
> Patch #3 adds a 'writable' parameter to kmv_phys_addr_ioremap() so that
> read-only device regions can be mapped using this function. The existing
> callers are updated to pass 'true' for this parameter.
> 
> Patch #4 and #5 were sent out before, and change the value of
> PAGE_S2_DEVICE to read-only, so that read-only regions can be
> ioremap()'ed
> 
> Patch #6 ensures that VM_PFNMAP linear mappings of non-system RAM host
> memory are mapped eagerly rather than faulted in page by page.
> 
> 
Thanks, applied patches 1 through 5 to kvmarm/queue with the fixups
discussed.

-Christoffer
