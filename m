From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 13 Jan 2016 21:48:44 +0100
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <56969F4B.7070001@imgtec.com>
References: <1452426622-4471-12-git-send-email-mst@redhat.com>
 <56945366.2090504@imgtec.com>
 <20160112092711.GP6344@twins.programming.kicks-ass.net>
 <20160112102555.GV6373@twins.programming.kicks-ass.net>
 <20160112104012.GW6373@twins.programming.kicks-ass.net>
 <20160112114111.GB15737@arm.com> <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com> <56969F4B.7070001@imgtec.com>
Message-ID: <20160113204844.GV6357@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 11:02:35AM -0800, Leonid Yegoshin wrote:

> I ask HW team about it but I have a question - has it any relationship with
> replacing MIPS SYNC with lightweight SYNCs (SYNC_WMB etc)?

Of course. If you cannot explain the semantics of the primitives you
introduce, how can we judge the patch.

This barrier business is hard enough as it is, but magic unexplained
hardware makes it impossible.

Rest assured, you (MIPS) isn't the first (nor likely the last) to go
through all this. We've had these discussions (and to a certain extend
are still having them) for x86, PPC, Alpha, ARM, etc..

Any every time new barriers instructions get introduced we had better
have a full and comprehensive explanation to go along with them.
