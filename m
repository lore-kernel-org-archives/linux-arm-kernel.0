From: davem@davemloft.net (David Miller)
Date: Thu, 31 Dec 2015 14:43:47 -0500 (EST)
Subject: [PATCH v2 07/32] sparc: reuse asm-generic/barrier.h
In-Reply-To: <1451572003-2440-8-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-8-git-send-email-mst@redhat.com>
Message-ID: <20151231.144347.54643465516219979.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 31 Dec 2015 21:06:38 +0200

> On sparc 64 bit dma_rmb, dma_wmb, smp_store_mb, smp_mb, smp_rmb,
> smp_wmb, read_barrier_depends and smp_read_barrier_depends match the
> asm-generic variants exactly. Drop the local definitions and pull in
> asm-generic/barrier.h instead.
> 
> nop uses __asm__ __volatile but is otherwise identical to
> the generic version, drop that as well.
> 
> This is in preparation to refactoring this code area.
> 
> Note: nop() was in processor.h and not in barrier.h as on other
> architectures. Nothing seems to depend on it being there though.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: David S. Miller <davem@davemloft.net>
