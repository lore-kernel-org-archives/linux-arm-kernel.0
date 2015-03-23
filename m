From: rientjes@google.com (David Rientjes)
Date: Mon, 23 Mar 2015 16:07:49 -0700 (PDT)
Subject: [PATCH v2] ARM: mm: Do not invoke OOM for higher order IOMMU
 DMA allocations
In-Reply-To: <1427095620-20994-1-git-send-email-tfiga@chromium.org>
References: <1427095620-20994-1-git-send-email-tfiga@chromium.org>
Message-ID: <alpine.DEB.2.10.1503231607380.24576@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Mar 2015, Tomasz Figa wrote:

> IOMMU should be able to use single pages as well as bigger blocks, so if
> higher order allocations fail, we should not affect state of the system,
> with events such as OOM killer, but rather fall back to order 0
> allocations.
> 
> This patch changes the behavior of ARM IOMMU DMA allocator to use
> __GFP_NORETRY, which bypasses OOM invocation, for orders higher than
> zero and, only if that fails, fall back to normal order 0 allocation
> which might invoke OOM killer.
> 
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>

Acked-by: David Rientjes <rientjes@google.com>
