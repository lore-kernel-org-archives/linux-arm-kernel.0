From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 19 Feb 2018 15:05:53 +0100
Subject: [RFC PATCH 3/5] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
In-Reply-To: <20180219140151.GE30394@arm.com>
References: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
 <1518708575-12284-4-git-send-email-will.deacon@arm.com>
 <20180215170847.GD25181@hirez.programming.kicks-ass.net>
 <20180215182049.GC15274@arm.com>
 <20180216103520.GC25201@hirez.programming.kicks-ass.net>
 <20180219140151.GE30394@arm.com>
Message-ID: <20180219140553.GT25201@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 02:01:51PM +0000, Will Deacon wrote:
> If it's defined, then we could consider using cmpxchg64 to build atomic64
> instead of the locks. But even then, I'm not sure we're really helping
> anybody out in practice.

yeah, most 64bit archs have more atomics or ll/sc and would not use it
anyway I suppose.
