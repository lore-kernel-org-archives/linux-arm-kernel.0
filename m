From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Nov 2014 11:47:44 +0000
Subject: [PATCH] arm64: compat: align cacheflush syscall with arch/arm
In-Reply-To: <1415789238-4573-1-git-send-email-vladimir.murzin@arm.com>
References: <1415789238-4573-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20141113114743.GG13350@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Wed, Nov 12, 2014 at 10:47:18AM +0000, Vladimir Murzin wrote:
> Update handling of cacheflush syscall with changes made in arch/arm
> counterpart:
>  - return error to userspace when flushing syscall fails
>  - split user cache-flushing into interruptible chunks
>  - don't bother rounding to nearest vma
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/cacheflush.h  |    2 +-
>  arch/arm64/include/asm/thread_info.h |   12 ++++++
>  arch/arm64/kernel/sys_compat.c       |   77 ++++++++++++++++++++++++----------
>  arch/arm64/mm/cache.S                |    6 ++-
>  4 files changed, 74 insertions(+), 23 deletions(-)

We should hold off on this patch until the EINTR issue has been resolved:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/302105.html

Will
