From: dianders@chromium.org (Doug Anderson)
Date: Mon, 23 Mar 2015 09:30:30 -0700
Subject: [PATCH v2] ARM: mm: Do not invoke OOM for higher order IOMMU DMA
 allocations
In-Reply-To: <1427095620-20994-1-git-send-email-tfiga@chromium.org>
References: <1427095620-20994-1-git-send-email-tfiga@chromium.org>
Message-ID: <CAD=FV=UMy9+o6h8jM8czevttJxaN_TGqDdZyj2=+1z=eZ9C7gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz,

On Mon, Mar 23, 2015 at 12:27 AM, Tomasz Figa <tfiga@chromium.org> wrote:
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
> ---
>  arch/arm/mm/dma-mapping.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)

FWIW:

Reviewed-by: Doug Anderson <dianders@chromium.org>
