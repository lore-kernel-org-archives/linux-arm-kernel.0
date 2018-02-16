From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 16 Feb 2018 15:18:29 +0100
Subject: [RFC PATCH 3/5] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
In-Reply-To: <20180216103520.GC25201@hirez.programming.kicks-ass.net>
References: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
 <1518708575-12284-4-git-send-email-will.deacon@arm.com>
 <20180215170847.GD25181@hirez.programming.kicks-ass.net>
 <20180215182049.GC15274@arm.com>
 <20180216103520.GC25201@hirez.programming.kicks-ass.net>
Message-ID: <20180216141829.GK25235@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 16, 2018 at 11:35:20AM +0100, Peter Zijlstra wrote:

> #define BIT_U32_MASK(nr)	(1UL << ((nr) % 32))
> #define BIT_U32_WORD(nr)	(((nr) / 32) ^ (4 * __BIG_ENDIAN__))

s/4 *//

it's already a 4 byte offset.
