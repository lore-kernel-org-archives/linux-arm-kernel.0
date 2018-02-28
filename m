From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 28 Feb 2018 13:08:28 +0100
Subject: [PATCH 01/29] arm64: mm: Use non-global mappings for kernel space
In-Reply-To: <1519790211-16582-2-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <1519790211-16582-2-git-send-email-alex.shi@linaro.org>
Message-ID: <20180228120828.GB8453@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 11:56:23AM +0800, Alex Shi wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> commit e046eb0c9bf2 upstream.
> 
> In preparation for unmapping the kernel whilst running in userspace,
> make the kernel mappings non-global so we can avoid expensive TLB
> invalidation on kernel exit to userspace.
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Laura Abbott <labbott@redhat.com>
> Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Alex Shi <alex.shi@linaro.org>
> 
> Conflicts:
> 	skip PTE_RDONLY of PAGE_NONE in arch/arm64/include/asm/pgtable-prot.h

These "Conflicts:" lines need to be removed, or put below the --- line
please.

thanks,

greg k-h
