From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 4 Jan 2016 14:26:10 +0100
Subject: [PATCH v2 11/32] mips: reuse asm-generic/barrier.h
In-Reply-To: <1451572003-2440-12-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-12-git-send-email-mst@redhat.com>
Message-ID: <20160104132610.GX6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 31, 2015 at 09:07:10PM +0200, Michael S. Tsirkin wrote:
> -#define smp_store_release(p, v)						\
> -do {									\
> -	compiletime_assert_atomic_type(*p);				\
> -	smp_mb();							\
> -	WRITE_ONCE(*p, v);						\
> -} while (0)
> -
> -#define smp_load_acquire(p)						\
> -({									\
> -	typeof(*p) ___p1 = READ_ONCE(*p);				\
> -	compiletime_assert_atomic_type(*p);				\
> -	smp_mb();							\
> -	___p1;								\
> -})

David Daney wanted to use fancy new MIPS barriers to provide better
implementations of this.

This patch isn't in the way of that, just a FYI.
