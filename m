From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 May 2017 14:48:58 +0100
Subject: [PATCH] arm64: Remove redundant mov from LL/SC cmpxchg
In-Reply-To: <f197f5369dfa1fe2a220da0950e5f5475382a920.1494593043.git.robin.murphy@arm.com>
References: <f197f5369dfa1fe2a220da0950e5f5475382a920.1494593043.git.robin.murphy@arm.com>
Message-ID: <20170515134858.GA11941@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 01:48:41PM +0100, Robin Murphy wrote:
> The cmpxchg implementation introduced by commit c342f78217e8 ("arm64:
> cmpxchg: patch in lse instructions when supported by the CPU") performs
> an apparently redundant register move of [old] to [oldval] in the
> success case - it always uses the same register width as [oldval] was
> originally loaded with, and is only executed when [old] and [oldval] are
> known to be equal anyway.
> 
> The only effect it seemingly does have is to take up a surprising amount
> of space in the kernel text, as removing it reveals:
> 
>    text	   data	    bss	    dec	    hex	filename
> 12426658	1348614	4499749	18275021	116dacd	vmlinux.o.new
> 12429238	1348614	4499749	18277601	116e4e1	vmlinux.o.old
> 
> Reviewed-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Queued for 4.12. Thanks.

-- 
Catalin
