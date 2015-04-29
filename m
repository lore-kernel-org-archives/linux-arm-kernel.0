From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 29 Apr 2015 16:23:41 +0100
Subject: [PATCH] arm64: add missing PAGE_ALIGN() to __dma_free()
In-Reply-To: <20150429150917.14395.31269.email-sent-by-dnelson@teal>
References: <20150429150917.14395.31269.email-sent-by-dnelson@teal>
Message-ID: <20150429152341.GD18867@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 11:09:18AM -0400, Dean Nelson wrote:
> __dma_alloc() does a PAGE_ALIGN() on the passed in size argument before
> doing anything else. __dma_free() does not. And because it doesn't, it is
> possible to leak memory should size not be an integer multiple of PAGE_SIZE.
> 
> The solution is to add a PAGE_ALIGN() to __dma_free() like is done in
> __dma_alloc().
> 
> Additionally, this patch removes a redundant PAGE_ALIGN() from
> __dma_alloc_coherent(), since __dma_alloc_coherent() can only be called
> from __dma_alloc(), which already does a PAGE_ALIGN() before the call.
> 
> Signed-off-by: Dean Nelson <dnelson@redhat.com>
> Cc: stable at vger.kernel.org

Thanks for posting this:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I guess Will is picking it up for 4.1

-- 
Catalin
