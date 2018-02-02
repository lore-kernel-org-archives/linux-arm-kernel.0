From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 2 Feb 2018 20:55:06 +0100
Subject: Runqueue spinlock recursion on arm64 v4.15
In-Reply-To: <20180202192704.nqwjsthl3agszhzt@lakrids.cambridge.arm.com>
References: <20180202192704.nqwjsthl3agszhzt@lakrids.cambridge.arm.com>
Message-ID: <20180202195506.GP2269@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 02, 2018 at 07:27:04PM +0000, Mark Rutland wrote:
> ... in some cases, owner_cpu is -1, so I guess we're racing with an
> unlock. I only ever see this on the runqueue locks in wake up functions.

So runqueue locks are special in that the owner changes over a contex
switch, maybe something goes funny there?
