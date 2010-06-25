From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 25 Jun 2010 17:00:35 +0100
Subject: [PATCH 0/2] Barrier changes with !ARM_DMA_MEM_BUFFERABLE
In-Reply-To: <20100621115703.7162.95491.stgit@e102109-lin.cambridge.arm.com>
References: <20100621115703.7162.95491.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <1277481635.13134.62.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Mon, 2010-06-21 at 13:23 +0100, Catalin Marinas wrote:
> The patches are relatively simple but without them the RealView boards
> cannot be used with L210/L220 enabled (hardware deadlock, not a software
> issue).
> 
> Catalin Marinas (2):
>       ARM: Do not use outer_sync() in mb() if !ARM_DMA_MEM_BUFFERABLE
>       ARM: Do not enable ARM_DMA_MEM_BUFFERABLE for some RealView boards

Are you ok with these patches, especially the first one?

Alternatively, I can implement the barriers in the RealView code (though
the second patch is still needed as I'll drop the outer_sync() for ARMv6
RealView).

Thanks.

-- 
Catalin
